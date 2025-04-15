{
  security = {
    rtkit.enable = true;
    sudo.enable = true;
    # PAM must be configured to enable hyprlock to perform authentication
    pam.services.hyprlock = {};
  };
}
