enum UserRoles {
  user,
  vendor,
  admin;
}

class UserRoleHelper {
  static String getValue(UserRoles role) {
    switch (role) {
      case UserRoles.user:
        return "user";
      case UserRoles.vendor:
        return "vendor";
      case UserRoles.admin:
        return "admin";
      default:
        return "";
    }
  }
}
