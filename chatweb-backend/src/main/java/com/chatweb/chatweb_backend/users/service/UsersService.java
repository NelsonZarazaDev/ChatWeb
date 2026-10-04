package com.chatweb.chatweb_backend.users.service;

import com.chatweb.chatweb_backend.users.dto.UserRequest;
import com.chatweb.chatweb_backend.users.dto.UserResponse;

import java.util.List;
import java.util.UUID;

public interface UsersService {
    UserResponse createUsers(UserRequest userRequest);
    List<UserResponse> getAllUser();
    UserResponse updateUser(UUID id, UserRequest userRequest);
}