package com.example.demo.framework;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.cassandra.CassandraProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.data.cassandra.config.AbstractCassandraConfiguration;
import org.springframework.data.cassandra.config.SessionBuilderConfigurer;
import org.springframework.data.cassandra.core.cql.keyspace.CreateKeyspaceSpecification;
import org.springframework.data.cassandra.core.cql.keyspace.DropKeyspaceSpecification;
import org.springframework.data.cassandra.core.cql.session.init.KeyspacePopulator;
import org.springframework.data.cassandra.core.cql.session.init.ResourceKeyspacePopulator;
import org.springframework.util.StringUtils;

import lombok.Getter;
import lombok.Setter;

/**
 * Merge connection information from Spring Spring Boot Cassandra
 * Autoconfiguration and {@link AstraBuilderConfig} and creates
 * {@link AbstractCassandraConfiguration} to initialize the keyspace with
 * scripts from the schema.cql file
 */
@Configuration
@ConfigurationProperties(prefix = "spring.data.cassandra")
public class AstraCassandraConfig extends AbstractCassandraConfiguration {

    @Getter
    @Setter
    private Boolean keyspacePopulator = false;

    @Getter
    @Setter
    private String keyspacePopulatorResourceName = "classpath:schema.cql";

    @Autowired
    private AstraBuilderConfig astraConfig;

    @Autowired
    private CassandraProperties cassandraProperties;

    @Autowired
    private ResourceLoader resourceLoader;

    /**
     * Merge connection information from Spring Spring Boot Cassandra
     * Autoconfiguration and {@link AstraBuilderConfig}
     */
    @Override
    protected SessionBuilderConfigurer getSessionBuilderConfigurer() {
        return (builder) -> astraConfig.configCqlSessionBuilderWithAstraProps(builder)
                .withAuthCredentials(cassandraProperties.getUsername(), cassandraProperties.getPassword());
    }

    /**
     * Transfer ContactPoints from Spring Spring Boot Cassandra Autoconfiguration to
     * AbstractCassandraConfiguration
     */
    @Override
    protected String getContactPoints() {
        return StringUtils.collectionToCommaDelimitedString(cassandraProperties.getContactPoints());
    }

    /**
     * Transfer KeyspaceName from Spring Spring Boot Cassandra Autoconfiguration to
     * AbstractCassandraConfiguration
     */
    @Override
    protected String getKeyspaceName() {
        return cassandraProperties.getKeyspaceName();
    }

    /**
     * Transfer LocalDataCenter from Spring Spring Boot Cassandra Autoconfiguration
     * to AbstractCassandraConfiguration
     */
    @Override
    protected String getLocalDataCenter() {
        return cassandraProperties.getLocalDatacenter();
    }

    /**
     * Transfer Port from Spring Spring Boot Cassandra Autoconfiguration to
     * AbstractCassandraConfiguration
     */
    @Override
    protected int getPort() {
        return cassandraProperties.getPort();
    }

    @Override
    protected List<CreateKeyspaceSpecification> getKeyspaceCreations() {
        return super.getKeyspaceCreations();
    }

    @Override
    protected List<DropKeyspaceSpecification> getKeyspaceDrops() {
        return super.getKeyspaceDrops();
    }

    /**
     * Get resource from file schema.cql and set on AbstractCassandraConfiguration
     */
    @Override
    protected KeyspacePopulator keyspacePopulator() {
        if (this.keyspacePopulator) {
            Resource resource = resourceLoader.getResource(this.keyspacePopulatorResourceName);
            if (resource.exists()) {
                return new ResourceKeyspacePopulator(true, true, null, resource);
            }
        }
        return null;
    }
}
