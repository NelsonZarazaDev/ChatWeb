package com.chatweb.chatweb_backend.users.repository;

import com.chatweb.chatweb_backend.users.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface UsersRepository extends JpaRepository<Users, UUID> {
}
