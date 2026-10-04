package com.chatweb.chatweb_backend.users.service.impl;

import com.chatweb.chatweb_backend.users.dto.UserRequest;
import com.chatweb.chatweb_backend.users.dto.UserResponse;
import com.chatweb.chatweb_backend.users.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsersServiceImpl implements UsersService {
    @Override
    public UserResponse createUsers(UserRequest userRequest) {
        return null;
    }

    @Override
    public List<UserResponse> getAllUser() {
        return List.of();
    }

    @Override
    public UserResponse updateUser(UUID id, UserRequest userRequest) {
        return null;
    }
}
