package com.example.demo.framework;

import java.nio.file.Paths;

import com.datastax.oss.driver.api.core.CqlSessionBuilder;

import org.springframework.boot.autoconfigure.cassandra.CqlSessionBuilderCustomizer;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

/**
 * Customize {@link CqlSessionBuilder} by adding Secure Connect Bundle (Cloud)
 * information
 */
@Configuration
@ConfigurationProperties(prefix = "astra")
public class AstraBuilderConfig {

    /** Setup ConnectBundle from Astra. */
    @Getter
    @Setter
    private String secureConnectBundlePath;

    /**
     * Customizer {@link CqlSessionBuilderCustomizer} from Spring Boot Cassandra
     * Autoconfiguration add configuration from {@link AstraBuilderConfig},
     * including Secure Connect Bundle Path
     */
    @Bean
    CqlSessionBuilderCustomizer customizerWithAstraConfig(AstraBuilderConfig astraConfig) {
        return (builder) -> astraConfig.configCqlSessionBuilderWithAstraProps(builder);
    }

    /**
     * Add Secure Connect Bundle on {@link CqlSessionBuilder}
     * information
     */
    public CqlSessionBuilder configCqlSessionBuilderWithAstraProps(CqlSessionBuilder builder) {
        if (null != this.getSecureConnectBundlePath() && !"".equals(this.getSecureConnectBundlePath())) {
            builder = builder.withCloudSecureConnectBundle(Paths.get(this.getSecureConnectBundlePath()));
        }
        return builder;
    }

}
