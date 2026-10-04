package com.chatweb.chatweb_backend;

import org.springframework.boot.SpringApplication;

public class TestChatwebBackendApplication {

	public static void main(String[] args) {
		SpringApplication.from(ChatwebBackendApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
