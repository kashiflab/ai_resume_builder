enum AppRoute {
  // Auth
  signIn('/auth/sign-in'),
  signUp('/auth/sign-up'),
  forgotPassword('/auth/forgot-password'),
  resetPassword('/auth/reset-password'),

  // Dashboard
  dashboard('/dashboard'),
  quickActions('/quick-actions'),
  notifications('/notifications'),

  // Resume
  createResume('/resume/create'),
  importResume('/resume/import'),
  editResume('/resume/edit'),
  previewResume('/resume/preview'),

  // Settings
  settingsProfile('/settings/profile'),
  settingsChangePassword('/settings/change-password'),
  settingsSubscription('/settings/subscription'),
  settingsTemplate('/settings/template'),
  settingsFonts('/settings/fonts'),
  settingsExport('/settings/export'),
  settingsNotifications('/settings/notifications'),

  // Support
  help('/help'),
  about('/about');

  const AppRoute(this.path);
  final String path;
}
