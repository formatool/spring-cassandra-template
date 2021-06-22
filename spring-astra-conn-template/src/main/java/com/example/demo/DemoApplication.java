package com.example.demo;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@Autowired 
	CqlSession session;	

	@Bean
	@ConditionalOnProperty(name="init.info.show", havingValue="true")
	CommandLineRunner initInfo() {
		return (args) -> {
            // Print the release_version to the console
            ResultSet rs = session.execute("select release_version from system.local");
            Row row = rs.one();            
            if (row != null) {
                System.out.println("Cassandra Version: ".concat(row.getString("release_version")));
            }
			//Print metadatas to the console
			session.getKeyspace().ifPresent((k)->System.out.println("Keyspace Atual: ".concat(k.asCql(true))));
			session.getMetadata().getKeyspaces().forEach((kident, kmetadata) -> {
				System.out.println("Tables Keyspace ".concat(kident.asCql(true)));
				kmetadata.getTables().forEach((tident,tmetadata)-> {
					System.out.println("  Table: ".concat(tident.asCql(true)));
				});
			});
		};
	}

}
