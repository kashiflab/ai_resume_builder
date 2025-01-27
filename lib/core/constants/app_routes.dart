enum AppRoute {
  signIn('/signin'),
  signUp('/signup'),
  forgotPassword('/forgot-password'),
  dashboard('/dashboard'),
  home('/home'),
  templates('/templates'),
  saved('/saved'),
  profile('/profile'),
  settings('/settings'),
  settingsProfile('/settings/profile'),
  settingsChangePassword('/settings/change-password'),
  settingsSubscription('/settings/subscription'),
  settingsTemplate('/settings/template'),
  settingsFonts('/settings/fonts'),
  settingsExport('/settings/export'),
  settingsBackup('/settings/backup'),
  settingsLanguage('/settings/language'),
  settingsNotifications('/settings/notifications'),
  help('/help'),
  about('/about'),
  createResume('/create-resume'),
  aiAnalyzeSection('/ai-analyze-section'),
  quickActions('/quick-actions');

  final String path;
  const AppRoute(this.path);
}
