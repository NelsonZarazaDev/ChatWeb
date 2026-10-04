package com.chatweb.chatweb_backend.users.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserRequest {
    private String firstName;
    private String lastName;
    private String gender;
    private String email;
    private String phoneNumber;
    private Boolean status;
    private String password;
}
