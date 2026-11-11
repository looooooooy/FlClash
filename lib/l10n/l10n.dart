Warning: truncated output (original token count: 56282)
Total output lines: 9391

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Rule`
  String get rule {
    return Intl.message('Rule', name: 'rule', desc: '', args: []);
  }

  /// `Rules`
  String get rules {
    return Intl.message('Rules', name: 'rules', desc: '', args: []);
  }

  /// `Global`
  String get global {
    return Intl.message('Global', name: 'global', desc: '', args: []);
  }

  /// `Direct`
  String get direct {
    return Intl.message('Direct', name: 'direct', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Proxies`
  String get proxies {
    return Intl.message('Proxies', name: 'proxies', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profiles`
  String get profiles {
    return Intl.message('Profiles', name: 'profiles', desc: '', args: []);
  }

  /// `Tools`
  String get tools {
    return Intl.message('Tools', name: 'tools', desc: '', args: []);
  }

  /// `Logs`
  String get logs {
    return Intl.message('Logs', name: 'logs', desc: '', args: []);
  }

  /// `Resources`
  String get resources {
    return Intl.message('Resources', name: 'resources', desc: '', args: []);
  }

  /// `Traffic usage`
  String get trafficUsage {
    return Intl.message(
      'Traffic usage',
      name: 'trafficUsage',
      desc: '',
      args: [],
    );
  }

  /// `Network speed`
  String get networkSpeed {
    return Intl.message(
      'Network speed',
      name: 'networkSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Outbound mode`
  String get outboundMode {
    return Intl.message(
      'Outbound mode',
      name: 'outboundMode',
      desc: '',
      args: [],
    );
  }

  /// `Service status`
  String get serviceStatus {
    return Intl.message(
      'Service status',
      name: 'serviceStatus',
      desc: '',
      args: [],
    );
  }

  /// `Access restricted`
  String get serviceRestricted {
    return Intl.message(
      'Access restricted',
      name: 'serviceRestricted',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get serviceAvailable {
    return Intl.message(
      'Available',
      name: 'serviceAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get serviceUnavailable {
    return Intl.message(
      'Unavailable',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Check failed`
  String get serviceFailed {
    return Intl.message(
      'Check failed',
      name: 'serviceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Disallowed ISP`
  String get serviceDisallowedIsp {
    return Intl.message(
      'Disallowed ISP',
      name: 'serviceDisallowedIsp',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get serviceBlocked {
    return Intl.message('Blocked', name: 'serviceBlocked', desc: '', args: []);
  }

  /// `Region not supported`
  String get serviceUnsupportedRegion {
    return Intl.message(
      'Region not supported',
      name: 'serviceUnsupportedRegion',
      desc: '',
      args: [],
    );
  }

  /// `Originals only`
  String get serviceOriginalsOnly {
    return Intl.message(
      'Originals only',
      name: 'serviceOriginalsOnly',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get serviceComingSoon {
    return Intl.message(
      'Coming soon',
      name: 'serviceComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Not checked`
  String get servicePending {
    return Intl.message(
      'Not checked',
      name: 'servicePending',
      desc: '',
      args: [],
    );
  }

  /// `Manage services`
  String get serviceManage {
    return Intl.message(
      'Manage services',
      name: 'serviceManage',
      desc: '',
      args: [],
    );
  }

  /// `Check all`
  String get serviceCheckAll {
    return Intl.message(
      'Check all',
      name: 'serviceCheckAll',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `Used traffic`
  String get usedTraffic {
    return Intl.message(
      'Used traffic',
      name: 'usedTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Total traffic`
  String get totalTraffic {
    return Intl.message(
      'Total traffic',
      name: 'totalTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Expiration time`
  String get expireTime {
    return Intl.message(
      'Expiration time',
      name: 'expireTime',
      desc: '',
      args: [],
    );
  }

  /// `Add a profile to get started`
  String get nullProfileDesc {
    return Intl.message(
      'Add a profile to get started',
      name: 'nullProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Default`
  String get defaultText {
    return Intl.message('Default', name: 'defaultText', desc: '', args: []);
  }

  /// `More`
  String get more {
    return Intl.message('More', name: 'more', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Spanish`
  String get es {
    return Intl.message('Spanish', name: 'es', desc: '', args: []);
  }

  /// `French`
  String get fr {
    return Intl.message('French', name: 'fr', desc: '', args: []);
  }

  /// `Japanese`
  String get ja {
    return Intl.message('Japanese', name: 'ja', desc: '', args: []);
  }

  /// `Korean`
  String get ko {
    return Intl.message('Korean', name: 'ko', desc: '', args: []);
  }

  /// `Russian`
  String get ru {
    return Intl.message('Russian', name: 'ru', desc: '', args: []);
  }

  /// `Simplified Chinese`
  String get zhCN {
    return Intl.message('Simplified Chinese', name: 'zhCN', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Extend`
  String get extend {
    return Intl.message('Extend', name: 'extend', desc: '', args: []);
  }

  /// `Runtime config`
  String get runtimeConfig {
    return Intl.message(
      'Runtime config',
      name: 'runtimeConfig',
      desc: '',
      args: [],
    );
  }

  /// `Allow LAN`
  String get allowLan {
    return Intl.message('Allow LAN', name: 'allowLan', desc: '', args: []);
  }

  /// `TUN`
  String get tun {
    return Intl.message('TUN', name: 'tun', desc: '', args: []);
  }

  /// `TUN works only in administrator mode.`
  String get tunDesc {
    return Intl.message(
      'TUN works only in administrator mode.',
      name: 'tunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Minimize on exit`
  String get minimizeOnExit {
    return Intl.message(
      'Minimize on exit',
      name: 'minimizeOnExit',
      desc: '',
      args: [],
    );
  }

  /// `Auto launch`
  String get autoLaunch {
    return Intl.message('Auto launch', name: 'autoLaunch', desc: '', args: []);
  }

  /// `Silent launch`
  String get silentLaunch {
    return Intl.message(
      'Silent launch',
      name: 'silentLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Auto run`
  String get autoRun {
    return Intl.message('Auto run', name: 'autoRun', desc: '', args: []);
  }

  /// `Auto run starts the proxy when the app opens.`
  String get autoRunDesc {
    return Intl.message(
      'Auto run starts the proxy when the app opens.',
      name: 'autoRunDesc',
      desc: '',
      args: [],
    );
  }

  /// `Logcat`
  String get logcat {
    return Intl.message('Logcat', name: 'logcat', desc: '', args: []);
  }

  /// `Turning off Logcat hides the logs entry.`
  String get logcatDesc {
    return Intl.message(
      'Turning off Logcat hides the logs entry.',
      name: 'logcatDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto check for updates`
  String get autoCheckUpdate {
    return Intl.message(
      'Auto check for updates',
      name: 'autoCheckUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Verify TLS certificates`
  String get checkCertificate {
    return Intl.message(
      'Verify TLS certificates',
      name: 'checkCertificate',
      desc: '',
      args: [],
    );
  }

  /// `With TLS verification off, subscriptions and backups are open to man-in-the-middle attacks.`
  String get checkCertificateDesc {
    return Intl.message(
      'With TLS verification off, subscriptions and backups are open to man-in-the-middle attacks.',
      name: 'checkCertificateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Access control`
  String get accessControl {
    return Intl.message(
      'Access control',
      name: 'accessControl',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `seconds`
  String get seconds {
    return Intl.message('seconds', name: 'seconds', desc: '', args: []);
  }

  /// `QR code`
  String get qrcode {
    return Intl.message('QR code', name: 'qrcode', desc: '', args: []);
  }

  /// `Scan a QR code to obtain a profile`
  String get qrcodeDesc {
    return Intl.message(
      'Scan a QR code to obtain a profile',
      name: 'qrcodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message('URL', name: 'url', desc: '', args: []);
  }

  /// `Link`
  String get link {
    return Intl.message('Link', name: 'link', desc: '', args: []);
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please enter the profile name`
  String get profileNameNullValidationDesc {
    return Intl.message(
      'Please enter the profile name',
      name: 'profileNameNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Please enter the profile URL`
  String get profileUrlNullValidationDesc {
    return Intl.message(
      'Please enter the profile URL',
      name: 'profileUrlNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid profile URL`
  String get profileUrlInvalidValidationDesc {
    return Intl.message(
      'Please enter a valid profile URL',
      name: 'profileUrlInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Auto update`
  String get autoUpdate {
    return Intl.message('Auto update', name: 'autoUpdate', desc: '', args: []);
  }

  /// `Auto-update interval`
  String get autoUpdateInterval {
    return Intl.message(
      'Auto-update interval',
      name: 'autoUpdateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the auto-update interval`
  String get profileAutoUpdateIntervalNullValidationDesc {
    return Intl.message(
      'Please enter the auto-update interval',
      name: 'profileAutoUpdateIntervalNullValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid interval`
  String get profileAutoUpdateIntervalInvalidValidationDesc {
    return Intl.message(
      'Please enter a valid interval',
      name: 'profileAutoUpdateIntervalInvalidValidationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Theme mode`
  String get themeMode {
    return Intl.message('Theme mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Theme color`
  String get themeColor {
    return Intl.message('Theme color', name: 'themeColor', desc: '', args: []);
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Auto`
  String get auto {
    return Intl.message('Auto', name: 'auto', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Import from link`
  String get importFromLink {
    return Intl.message(
      'Import from link',
      name: 'importFromLink',
      desc: '',
      args: [],
    );
  }

  /// `Send from phone`
  String get sendFromPhone {
    return Intl.message(
      'Send from phone',
      name: 'sendFromPhone',
      desc: '',
      args: [],
    );
  }

  /// `Scan the code with your phone's camera and paste the link on the page that opens. Both devices need to be on the same network.`
  String get sendFromPhoneTip {
    return Intl.message(
      'Scan the code with your phone\'s camera and paste the link on the page that opens. Both devices need to be on the same network.',
      name: 'sendFromPhoneTip',
      desc: '',
      args: [],
    );
  }

  /// `This device is not connected to a local network`
  String get sendFromPhoneNoNetwork {
    return Intl.message(
      'This device is not connected to a local network',
      name: 'sendFromPhoneNoNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Receiving a link from your phone needs the Nearby devices permission, which lets FlClash reach the local network. Turn it on in the app's settings.`
  String get sendFromPhonePermissionDenied {
    return Intl.message(
      'Receiving a link from your phone needs the Nearby devices permission, which lets FlClash reach the local network. Turn it on in the app\'s settings.',
      name: 'sendFromPhonePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Send a link to FlClash`
  String get sendFromPhonePageTitle {
    return Intl.message(
      'Send a link to FlClash',
      name: 'sendFromPhonePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscription link or proxy share link`
  String get sendFromPhonePageHint {
    return Intl.message(
      'Subscription link or proxy share link',
      name: 'sendFromPhonePageHint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Sent. Confirm the import on the other device.`
  String get sendFromPhonePageSent {
    return Intl.message(
      'Sent. Confirm the import on the other device.',
      name: 'sendFromPhonePageSent',
      desc: '',
      args: [],
    );
  }

  /// `Import the link from your phone?`
  String get sendFromPhoneConfirmTitle {
    return Intl.message(
      'Import the link from your phone?',
      name: 'sendFromPhoneConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan with FlClash on another device to import this profile.`
  String get shareQrcodeTip {
    return Intl.message(
      'Scan with FlClash on another device to import this profile.',
      name: 'shareQrcodeTip',
      desc: '',
      args: [],
    );
  }

  /// `This link is too long for a QR code. Use Copy link instead.`
  String get qrcodeTooLongTip {
    return Intl.message(
      'This link is too long for a QR code. Use Copy link instead.',
      name: 'qrcodeTooLongTip',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Do you want to create a profile from {url}?`
  String createProfileFromUrlTip(Object url) {
    return Intl.message(
      'Do you want to create a profile from $url?',
      name: 'createProfileFromUrlTip',
      desc: '',
      args: [url],
    );
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Please upload a valid QR code`
  String get pleaseUploadValidQrcode {
    return Intl.message(
      'Please upload a valid QR code',
      name: 'pleaseUploadValidQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist mode`
  String get blacklistMode {
    return Intl.message(
      'Blacklist mode',
      name: 'blacklistMode',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist mode`
  String get whitelistMode {
    return Intl.message(
      'Whitelist mode',
      name: 'whitelistMode',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get selectAll {
    return Intl.message('Select all', name: 'selectAll', desc: '', args: []);
  }

  /// `Deselect all`
  String get cancelSelectAll {
    return Intl.message(
      'Deselect all',
      name: 'cancelSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `App access control`
  String get appAccessControl {
    return Intl.message(
      'App access control',
      name: 'appAccessControl',
      desc: '',
      args: [],
    );
  }

  /// `Only selected apps go through the VPN`
  String get accessControlAllowDesc {
    return Intl.message(
      'Only selected apps go through the VPN',
      name: 'accessControlAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Selected apps are excluded from the VPN`
  String get accessControlNotAllowDesc {
    return Intl.message(
      'Selected apps are excluded from the VPN',
      name: 'accessControlNotAllowDesc',
      desc: '',
      args: [],
    );
  }

  /// `App access control is disabled`
  String get accessControlDisabledDesc {
    return Intl.message(
      'App access control is disabled',
      name: 'accessControlDisabledDesc',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, other{{count} selected}}`
  String accessControlSelectedCount(num count) {
    return Intl.plural(
      count,
      other: '$count selected',
      name: 'accessControlSelectedCount',
      desc: '',
      args: [count],
    );
  }

  /// `Port`
  String get port {
    return Intl.message('Port', name: 'port', desc: '', args: []);
  }

  /// `Log level`
  String get logLevel {
    return Intl.message('Log level', name: 'logLevel', desc: '', args: []);
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `System proxy`
  String get systemProxy {
    return Intl.message(
      'System proxy',
      name: 'systemProxy',
      desc: '',
      args: [],
    );
  }

  /// `Safe mode`
  String get safeMode {
    return Intl.message('Safe mode', name: 'safeMode', desc: '', args: []);
  }

  /// `{appName} (Safe mode)`
  String safeModeAppTitle(Object appName) {
    return Intl.message(
      '$appName (Safe mode)',
      name: 'safeModeAppTitle',
      desc: '',
      args: [appName],
    );
  }

  /// `Project`
  String get project {
    return Intl.message('Project', name: 'project', desc: '', args: []);
  }

  /// `Core`
  String get core {
    return Intl.message('Core', name: 'core', desc: '', args: []);
  }

  /// `Tab animation`
  String get tabAnimation {
    return Intl.message(
      'Tab animation',
      name: 'tabAnimation',
      desc: '',
      args: [],
    );
  }

  /// `A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.`
  String get desc {
    return Intl.message(
      'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Starting VPN…`
  String get startVpn {
    return Intl.message('Starting VPN…', name: 'startVpn', desc: '', args: []);
  }

  /// `Stopping VPN…`
  String get stopVpn {
    return Intl.message('Stopping VPN…', name: 'stopVpn', desc: '', args: []);
  }

  /// `Local network permission denied: using the gvisor stack, LAN is unreachable.`
  String get localNetworkDeniedTip {
    return Intl.message(
      'Local network permission denied: using the gvisor stack, LAN is unreachable.',
      name: 'localNetworkDeniedTip',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility mode`
  String get compatible {
    return Intl.message(
      'Compatibility mode',
      name: 'compatible',
      desc: '',
      args: [],
    );
  }

  /// `The current proxy group cannot be selected`
  String get notSelectedTip {
    return Intl.message(
      'The current proxy group cannot be selected',
      name: 'notSelectedTip',
      desc: '',
      args: [],
    );
  }

  /// `Failed to switch proxy; the previous selection has been restored`
  String get changeProxyFailedTip {
    return Intl.message(
      'Failed to switch proxy; the previous selection has been restored',
      name: 'changeProxyFailedTip',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save the change; it has been rolled back`
  String get databaseWriteFailedTip {
    return Intl.message(
      'Failed to save the change; it has been rolled back',
      name: 'databaseWriteFailedTip',
      desc: '',
      args: [],
    );
  }

  /// `Tip`
  String get tip {
    return Intl.message('Tip', name: 'tip', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Backup successful`
  String get backupSuccess {
    return Intl.message(
      'Backup successful',
      name: 'backupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No info`
  String get noInfo {
    return Intl.message('No info', name: 'noInfo', desc: '', args: []);
  }

  /// `Please bind WebDAV`
  String get pleaseBindWebDAV {
    return Intl.message(
      'Please bind WebDAV',
      name: 'pleaseBindWebDAV',
      desc: '',
      args: [],
    );
  }

  /// `Bind`
  String get bind {
    return Intl.message('Bind', name: 'bind', desc: '', args: []);
  }

  /// `Connectivity: `
  String get connectivity {
    return Intl.message(
      'Connectivity: ',
      name: 'connectivity',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV configuration`
  String get webDAVConfiguration {
    return Intl.message(
      'WebDAV configuration',
      name: 'webDAVConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Please enter a valid WebDAV address`
  String get addressTip {
    return Intl.message(
      'Please enter a valid WebDAV address',
      name: 'addressTip',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Authentication`
  String get authentication {
    return Intl.message(
      'Authentication',
      name: 'authentication',
      desc: '',
      args: [],
    );
  }

  /// `The system proxy is not applied while authentication is on.`
  String get authenticationSystemProxyDesc {
    return Intl.message(
      'The system proxy is not applied while authentication is on.',
      name: 'authenticationSystemProxyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Check for updates`
  String get checkUpdate {
    return Intl.message(
      'Check for updates',
      name: 'checkUpdate',
      desc: '',
      args: [],
    );
  }

  /// `New version found`
  String get discoverNewVersion {
    return Intl.message(
      'New version found',
      name: 'discoverNewVersion',
      desc: '',
      args: [],
    );
  }

  /// `The app is already up to date`
  String get checkUpdateError {
    return Intl.message(
      'The app is already up to date',
      name: 'checkUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get goDownload {
    return Intl.message('Download', name: 'goDownload', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Region`
  String get country {
    return Intl.message('Region', name: 'country', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Allow apps to bypass VPN`
  String get allowBypass {
    return Intl.message(
      'Allow apps to bypass VPN',
      name: 'allowBypass',
      desc: '',
      args: [],
    );
  }

  /// `External controller`
  String get externalController {
    return Intl.message(
      'External controller',
      name: 'externalController',
      desc: '',
      args: [],
    );
  }

  /// `The external controller lets you control the core on port 9090.`
  String get externalControllerDesc {
    return Intl.message(
      'The external controller lets you control the core on port 9090.',
      name: 'externalControllerDesc',
      desc: '',
      args: [],
    );
  }

  /// `External controller secret`
  String get externalControllerSecret {
    return Intl.message(
      'External controller secret',
      name: 'externalControllerSecret',
      desc: '',
      args: [],
    );
  }

  /// `IPv6 traffic is received only while IPv6 is on.`
  String get ipv6Desc {
    return Intl.message(
      'IPv6 traffic is received only while IPv6 is on.',
      name: 'ipv6Desc',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get app {
    return Intl.message('App', name: 'app', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Startup and background`
  String get startupAndBackground {
    return Intl.message(
      'Startup and background',
      name: 'startupAndBackground',
      desc: '',
      args: [],
    );
  }

  /// `Requests and updates`
  String get requestsAndUpdates {
    return Intl.message(
      'Requests and updates',
      name: 'requestsAndUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Logs and diagnostics`
  String get logsAndDiagnostics {
    return Intl.message(
      'Logs and diagnostics',
      name: 'logsAndDiagnostics',
      desc: '',
      args: [],
    );
  }

  /// `User-Agent`
  String get userAgent {
    return Intl.message('User-Agent', name: 'userAgent', desc: '', args: []);
  }

  /// `Unified delay`
  String get unifiedDelay {
    return Intl.message(
      'Unified delay',
      name: 'unifiedDelay',
      desc: '',
      args: [],
    );
  }

  /// `TCP concurrent`
  String get tcpConcurrent {
    return Intl.message(
      'TCP concurrent',
      name: 'tcpConcurrent',
      desc: '',
      args: [],
    );
  }

  /// `Geo low-memory mode`
  String get geodataLoader {
    return Intl.message(
      'Geo low-memory mode',
      name: 'geodataLoader',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message('Requests', name: 'requests', desc: '', args: []);
  }

  /// `Recent requests`
  String get recentRequests {
    return Intl.message(
      'Recent requests',
      name: 'recentRequests',
      desc: '',
      args: [],
    );
  }

  /// `Find process`
  String get findProcessMode {
    return Intl.message(
      'Find process',
      name: 'findProcessMode',
      desc: '',
      args: [],
    );
  }

  /// `Init`
  String get init {
    return Intl.message('Init', name: 'init', desc: '', args: []);
  }

  /// `Never expires`
  String get infiniteTime {
    return Intl.message(
      'Never expires',
      name: 'infiniteTime',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get connections {
    return Intl.message('Connections', name: 'connections', desc: '', args: []);
  }

  /// `Live connections`
  String get liveConnections {
    return Intl.message(
      'Live connections',
      name: 'liveConnections',
      desc: '',
      args: [],
    );
  }

  /// `Inbound`
  String get inbound {
    return Intl.message('Inbound', name: 'inbound', desc: '', args: []);
  }

  /// `Intranet IP`
  String get intranetIP {
    return Intl.message('Intranet IP', name: 'intranetIP', desc: '', args: []);
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Cut`
  String get cut {
    return Intl.message('Cut', name: 'cut', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Couldn't copy to the clipboard. The selection may be too large`
  String get clipboardWriteFailed {
    return Intl.message(
      'Couldn\'t copy to the clipboard. The selection may be too large',
      name: 'clipboardWriteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Paste`
  String get paste {
    return Intl.message('Paste', name: 'paste', desc: '', args: []);
  }

  /// `Test URL`
  String get testUrl {
    return Intl.message('Test URL', name: 'testUrl', desc: '', args: []);
  }

  /// `Delay test timeout`
  String get delayTestTimeout {
    return Intl.message(
      'Delay test timeout',
      name: 'delayTestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get sync {
    return Intl.message('Sync', name: 'sync', desc: '', args: []);
  }

  /// `Hide from recent tasks`
  String get exclude {
    return Intl.message(
      'Hide from recent tasks',
      name: 'exclude',
      desc: '',
      args: [],
    );
  }

  /// `Compact`
  String get compact {
    return Intl.message('Compact', name: 'compact', desc: '', args: []);
  }

  /// `Tab`
  String get tab {
    return Intl.message('Tab', name: 'tab', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Delay`
  String get delay {
    return Intl.message('Delay', name: 'delay', desc: '', args: []);
  }

  /// `Style`
  String get style {
    return Intl.message('Style', name: 'style', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `Columns`
  String get columns {
    return Intl.message('Columns', name: 'columns', desc: '', args: []);
  }

  /// `Proxy group`
  String get proxyGroup {
    return Intl.message('Proxy group', name: 'proxyGroup', desc: '', args: []);
  }

  /// `Go`
  String get go {
    return Intl.message('Go', name: 'go', desc: '', args: []);
  }

  /// `External link`
  String get externalLink {
    return Intl.message(
      'External link',
      name: 'externalLink',
      desc: '',
      args: [],
    );
  }

  /// `Other contributors`
  String get otherContributors {
    return Intl.message(
      'Other contributors',
      name: 'otherContributors',
      desc: '',
      args: [],
    );
  }

  /// `App icon design`
  String get appIconDesign {
    return Intl.message(
      'App icon design',
      name: 'appIconDesign',
      desc: '',
      args: [],
    );
  }

  /// `Auto close connections`
  String get autoCloseConnections {
    return Intl.message(
      'Auto close connections',
      name: 'autoCloseConnections',
      desc: '',
      args: [],
    );
  }

  /// `Only count proxy traffic`
  String get onlyStatisticsProxy {
    return Intl.message(
      'Only count proxy traffic',
      name: 'onlyStatisticsProxy',
      desc: '',
      args: [],
    );
  }

  /// `Stop button in notification`
  String get showNotificationStopAction {
    return Intl.message(
      'Stop button in notification',
      name: 'showNotificationStopAction',
      desc: '',
      args: [],
    );
  }

  /// `Pure black mode`
  String get pureBlackMode {
    return Intl.message(
      'Pure black mode',
      name: 'pureBlackMode',
      desc: '',
      args: [],
    );
  }

  /// `Sidebar`
  String get sidebar {
    return Intl.message('Sidebar', name: 'sidebar', desc: '', args: []);
  }

  /// `Background blur`
  String get backgroundBlur {
    return Intl.message(
      'Background blur',
      name: 'backgroundBlur',
      desc: '',
      args: [],
    );
  }

  /// `Liquid Glass`
  String get liquidGlass {
    return Intl.message(
      'Liquid Glass',
      name: 'liquidGlass',
      desc: '',
      args: [],
    );
  }

  /// `TCP keep-alive interval`
  String get keepAliveIntervalDesc {
    return Intl.message(
      'TCP keep-alive interval',
      name: 'keepAliveIntervalDesc',
      desc: '',
      args: [],
    );
  }

  /// ` entries`
  String get entries {
    return Intl.message(' entries', name: 'entries', desc: '', args: []);
  }

  /// `Local`
  String get local {
    return Intl.message('Local', name: 'local', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Mode`
  String get mode {
    return Intl.message('Mode', name: 'mode', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Source`
  String get source {
    return Intl.message('Source', name: 'source', desc: '', args: []);
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Smart selection`
  String get intelligentSelected {
    return Intl.message(
      'Smart selection',
      name: 'intelligentSelected',
      desc: '',
      args: [],
    );
  }

  /// `Import from clipboard`
  String get clipboardImport {
    return Intl.message(
      'Import from clipboard',
      name: 'clipboardImport',
      desc: '',
      args: [],
    );
  }

  /// `No package names found in the clipboard`
  String get clipboardNoPackageNames {
    return Intl.message(
      'No package names found in the clipboard',
      name: 'clipboardNoPackageNames',
      desc: '',
      args: [],
    );
  }

  /// `Export to clipboard`
  String get clipboardExport {
    return Intl.message(
      'Export to clipboard',
      name: 'clipboardExport',
      desc: '',
      args: [],
    );
  }

  /// `Layout`
  String get layout {
    return Intl.message('Layout', name: 'layout', desc: '', args: []);
  }

  /// `Tight`
  String get tight {
    return Intl.message('Tight', name: 'tight', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Ultra`
  String get ultra {
    return Intl.message('Ultra', name: 'ultra', desc: '', args: []);
  }

  /// `Loose`
  String get loose {
    return Intl.message('Loose', name: 'loose', desc: '', args: []);
  }

  /// `Sort profiles`
  String get profilesSort {
    return Intl.message(
      'Sort profiles',
      name: 'profilesSort',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Run time`
  String get runTime {
    return Intl.message('Run time', name: 'runTime', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Key`
  String get key {
    return Intl.message('Key', name: 'key', desc: '', args: []);
  }

  /// `Value`
  String get value {
    return Intl.message('Value', name: 'value', desc: '', args: []);
  }

  /// `Options`
  String get options {
    return Intl.message('Options', name: 'options', desc: '', args: []);
  }

  /// `Enabled`
  String get enabled {
    return Intl.message('Enabled', name: 'enabled', desc: '', args: []);
  }

  /// `Disabled`
  String get disabled {
    return Intl.message('Disabled', name: 'disabled', desc: '', args: []);
  }

  /// `UWP loopback exemption`
  String get loopback {
    return Intl.message(
      'UWP loopback exemption',
      name: 'loopback',
      desc: '',
      args: [],
    );
  }

  /// `External resources`
  String get providers {
    return Intl.message(
      'External resources',
      name: 'providers',
      desc: '',
      args: [],
    );
  }

  /// `Proxy providers`
  String get proxyProviders {
    return Intl.message(
      'Proxy providers',
      name: 'proxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Rule providers`
  String get ruleProviders {
    return Intl.message(
      'Rule providers',
      name: 'ruleProviders',
      desc: '',
      args: [],
    );
  }

  /// `Only remote providers are supported`
  String get providerUrlTip {
    return Intl.message(
      'Only remote providers are supported',
      name: 'providerUrlTip',
      desc: '',
      args: [],
    );
  }

  /// `The rule set has no usable entries`
  String get ruleSetEmptyTip {
    return Intl.message(
      'The rule set has no usable entries',
      name: 'ruleSetEmptyTip',
      desc: '',
      args: [],
    );
  }

  /// `The rule set mixes domains and IP ranges, so its type cannot be told`
  String get ruleSetMixedTip {
    return Intl.message(
      'The rule set mixes domains and IP ranges, so its type cannot be told',
      name: 'ruleSetMixedTip',
      desc: '',
      args: [],
    );
  }

  /// `This mrs file cannot be read`
  String get ruleSetInvalidTip {
    return Intl.message(
      'This mrs file cannot be read',
      name: 'ruleSetInvalidTip',
      desc: '',
      args: [],
    );
  }

  /// `Subscription info`
  String get subscriptionInfo {
    return Intl.message(
      'Subscription info',
      name: 'subscriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get server {
    return Intl.message('Server', name: 'server', desc: '', args: []);
  }

  /// `Sync interval (minutes)`
  String get ntpInterval {
    return Intl.message(
      'Sync interval (minutes)',
      name: 'ntpInterval',
      desc: '',
      args: [],
    );
  }

  /// `Dialer proxy`
  String get dialerProxy {
    return Intl.message(
      'Dialer proxy',
      name: 'dialerProxy',
      desc: '',
      args: [],
    );
  }

  /// `Write to system`
  String get writeToSystem {
    return Intl.message(
      'Write to system',
      name: 'writeToSystem',
      desc: '',
      args: [],
    );
  }

  /// `Write to system also sets the system clock; Android ignores it.`
  String get writeToSystemDesc {
    return Intl.message(
      'Write to system also sets the system clock; Android ignores it.',
      name: 'writeToSystemDesc',
      desc: '',
      args: [],
    );
  }

  /// `Sniffer`
  String get sniffer {
    return Intl.message('Sniffer', name: 'sniffer', desc: '', args: []);
  }

  /// `Override destination`
  String get overrideDestination {
    return Intl.message(
      'Override destination',
      name: 'overrideDestination',
      desc: '',
      args: [],
    );
  }

  /// `Force DNS mapping`
  String get forceDnsMapping {
    return Intl.message(
      'Force DNS mapping',
      name: 'forceDnsMapping',
      desc: '',
      args: [],
    );
  }

  /// `Force DNS mapping also sniffs connections whose domain came from a DNS mapping.`
  String get forceDnsMappingDesc {
    return Intl.message(
      'Force DNS mapping also sniffs connections whose domain came from a DNS mapping.',
      name: 'forceDnsMappingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Parse pure IP`
  String get parsePureIp {
    return Intl.message(
      'Parse pure IP',
      name: 'parsePureIp',
      desc: '',
      args: [],
    );
  }

  /// `Force domains`
  String get forceDomain {
    return Intl.message(
      'Force domains',
      name: 'forceDomain',
      desc: '',
      args: [],
    );
  }

  /// `Force domains are sniffed too; other connections that already have a domain are left alone.`
  String get forceDomainDesc {
    return Intl.message(
      'Force domains are sniffed too; other connections that already have a domain are left alone.',
      name: 'forceDomainDesc',
      desc: '',
      args: [],
    );
  }

  /// `Skip domains`
  String get skipDomain {
    return Intl.message('Skip domains', name: 'skipDomain', desc: '', args: []);
  }

  /// `Skip source addresses`
  String get skipSrcAddress {
    return Intl.message(
      'Skip source addresses',
      name: 'skipSrcAddress',
      desc: '',
      args: [],
    );
  }

  /// `Skip destination addresses`
  String get skipDstAddress {
    return Intl.message(
      'Skip destination addresses',
      name: 'skipDstAddress',
      desc: '',
      args: [],
    );
  }

  /// `Protocols`
  String get sniffProtocols {
    return Intl.message(
      'Protocols',
      name: 'sniffProtocols',
      desc: '',
      args: [],
    );
  }

  /// `Ports`
  String get ports {
    return Intl.message('Ports', name: 'ports', desc: '', args: []);
  }

  /// `Override entries`
  String get overrideEntries {
    return Intl.message(
      'Override entries',
      name: 'overrideEntries',
      desc: '',
      args: [],
    );
  }

  /// `Add override entry`
  String get addOverrideEntry {
    return Intl.message(
      'Add override entry',
      name: 'addOverrideEntry',
      desc: '',
      args: [],
    );
  }

  /// `Entries added here replace the DNS of every URL and file profile; anything not added keeps the profile's own setting. Custom profiles set their DNS in their content.`
  String get dnsOverrideDesc {
    return Intl.message(
      'Entries added here replace the DNS of every URL and file profile; anything not added keeps the profile\'s own setting. Custom profiles set their DNS in their content.',
      name: 'dnsOverrideDesc',
      desc: '',
      args: [],
    );
  }

  /// `settings`
  String get settingEntries {
    return Intl.message('settings', name: 'settingEntries', desc: '', args: []);
  }

  /// `Add setting`
  String get addSettingEntry {
    return Intl.message(
      'Add setting',
      name: 'addSettingEntry',
      desc: '',
      args: [],
    );
  }

  /// `Applies to this profile only; anything not added uses its default.`
  String get profileSettingsDesc {
    return Intl.message(
      'Applies to this profile only; anything not added uses its default.',
      name: 'profileSettingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Health check`
  String get healthCheck {
    return Intl.message(
      'Health check',
      name: 'healthCheck',
      desc: '',
      args: [],
    );
  }

  /// `Discard the changes?`
  String get discardChanges {
    return Intl.message(
      'Discard the changes?',
      name: 'discardChanges',
      desc: '',
      args: [],
    );
  }

  /// `Quick edit`
  String get quickEdit {
    return Intl.message('Quick edit', name: 'quickEdit', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `With DNS off, the system DNS is used.`
  String get statusDesc {
    return Intl.message(
      'With DNS off, the system DNS is used.',
      name: 'statusDesc',
      desc: '',
      args: [],
    );
  }

  /// `Respect rules`
  String get respectRules {
    return Intl.message(
      'Respect rules',
      name: 'respectRules',
      desc: '',
      args: [],
    );
  }

  /// `Respect rules routes DNS connections by the rules and needs a Proxy Server Nameserver.`
  String get respectRulesDesc {
    return Intl.message(
      'Respect rules routes DNS connections by the rules and needs a Proxy Server Nameserver.',
      name: 'respectRulesDesc',
      desc: '',
      args: [],
    );
  }

  /// `DNS mode`
  String get dnsMode {
    return Intl.message('DNS mode', name: 'dnsMode', desc: '', args: []);
  }

  /// `Fake-IP range`
  String get fakeipRange {
    return Intl.message(
      'Fake-IP range',
      name: 'fakeipRange',
      desc: '',
      args: [],
    );
  }

  /// `Fake-IP filter`
  String get fakeipFilter {
    return Intl.message(
      'Fake-IP filter',
      name: 'fakeipFilter',
      desc: '',
      args: [],
    );
  }

  /// `Use hosts`
  String get useHosts {
    return Intl.message('Use hosts', name: 'useHosts', desc: '', args: []);
  }

  /// `Use system hosts`
  String get useSystemHosts {
    return Intl.message(
      'Use system hosts',
      name: 'useSystemHosts',
      desc: '',
      args: [],
    );
  }

  /// `Fallback filter`
  String get fallbackFilter {
    return Intl.message(
      'Fallback filter',
      name: 'fallbackFilter',
      desc: '',
      args: [],
    );
  }

  /// `Domain`
  String get domain {
    return Intl.message('Domain', name: 'domain', desc: '', args: []);
  }

  /// `Listen routing mark`
  String get listenRoutingMark {
    return Intl.message(
      'Listen routing mark',
      name: 'listenRoutingMark',
      desc: '',
      args: [],
    );
  }

  /// `Listen routing mark works only on Linux.`
  String get listenRoutingMarkDesc {
    return Intl.message(
      'Listen routing mark works only on Linux.',
      name: 'listenRoutingMarkDesc',
      desc: '',
      args: [],
    );
  }

  /// `IPv6 timeout (ms)`
  String get ipv6Timeout {
    return Intl.message(
      'IPv6 timeout (ms)',
      name: 'ipv6Timeout',
      desc: '',
      args: [],
    );
  }

  /// `Cache algorithm`
  String get cacheAlgorithm {
    return Intl.message(
      'Cache algorithm',
      name: 'cacheAlgorithm',
      desc: '',
      args: [],
    );
  }

  /// `Cache size`
  String get cacheMaxSize {
    return Intl.message('Cache size', name: 'cacheMaxSize', desc: '', args: []);
  }

  /// `Fake-IP range (IPv6)`
  String get fakeipRange6 {
    return Intl.message(
      'Fake-IP range (IPv6)',
      name: 'fakeipRange6',
      desc: '',
      args: [],
    );
  }

  /// `Fake-IP filter mode`
  String get fakeipFilterMode {
    return Intl.message(
      'Fake-IP filter mode',
      name: 'fakeipFilterMode',
      desc: '',
      args: [],
    );
  }

  /// `Fake-IP TTL`
  String get fakeipTtl {
    return Intl.message('Fake-IP TTL', name: 'fakeipTtl', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Show/Hide`
  String get actionView {
    return Intl.message('Show/Hide', name: 'actionView', desc: '', args: []);
  }

  /// `Start/Stop`
  String get actionStart {
    return Intl.message('Start/Stop', name: 'actionStart', desc: '', args: []);
  }

  /// `Switch mode`
  String get actionMode {
    return Intl.message('Switch mode', name: 'actionMode', desc: '', args: []);
  }

  /// `System proxy`
  String get actionProxy {
    return Intl.message(
      'System proxy',
      name: 'actionProxy',
      desc: '',
      args: [],
    );
  }

  /// `TUN`
  String get actionTun {
    return Intl.message('TUN', name: 'actionTun', desc: '', args: []);
  }

  /// `Rule mode`
  String get actionRuleMode {
    return Intl.message(
      'Rule mode',
      name: 'actionRuleMode',
      desc: '',
      args: [],
    );
  }

  /// `Global mode`
  String get actionGlobalMode {
    return Intl.message(
      'Global mode',
      name: 'actionGlobalMode',
      desc: '',
      args: [],
    );
  }

  /// `Direct mode`
  String get actionDirectMode {
    return Intl.message(
      'Direct mode',
      name: 'actionDirectMode',
      desc: '',
      args: [],
    );
  }

  /// `Test all delays`
  String get actionDelayTest {
    return Intl.message(
      'Test all delays',
      name: 'actionDelayTest',
      desc: '',
      args: [],
    );
  }

  /// `Update profiles`
  String get actionUpdateProfiles {
    return Intl.message(
      'Update profiles',
      name: 'actionUpdateProfiles',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer`
  String get disclaimer {
    return Intl.message('Disclaimer', name: 'disclaimer', desc: '', args: []);
  }

  /// `Before using FlClash ("the Software"), please read this statement carefully and make sure you understand it. Tapping "Agree" means you have read and understood what follows. If you do not want to continue, tap "Exit".`
  String get disclaimerDesc {
    return Intl.message(
      'Before using FlClash ("the Software"), please read this statement carefully and make sure you understand it. Tapping "Agree" means you have read and understood what follows. If you do not want to continue, tap "Exit".',
      name: 'disclaimerDesc',
      desc: '',
      args: [],
    );
  }

  /// `Nature of the software`
  String get disclaimerSoftwareTitle {
    return Intl.message(
      'Nature of the software',
      name: 'disclaimerSoftwareTitle',
      desc: '',
      args: [],
    );
  }

  /// `The Software is an open-source network proxy client built on the Clash.Meta (mihomo) core. It only provides local tooling such as configuration management, rule-based routing, and traffic forwarding.`
  String get disclaimerSoftwareContent {
    return Intl.message(
      'The Software is an open-source network proxy client built on the Clash.Meta (mihomo) core. It only provides local tooling such as configuration management, rule-based routing, and traffic forwarding.',
      name: 'disclaimerSoftwareContent',
      desc: '',
      args: [],
    );
  }

  /// `The Software itself does not provide any proxy server, node, subscription, or network access service, and has no partnership, agency, or guarantee relationship with any provider of such services.`
  String get disclaimerNoServiceStatement {
    return Intl.message(
      'The Software itself does not provide any proxy server, node, subscription, or network access service, and has no partnership, agency, or guarantee relationship with any provider of such services.',
      name: 'disclaimerNoServiceStatement',
      desc: '',
      args: [],
    );
  }

  /// `About use`
  String get disclaimerUsageTitle {
    return Intl.message(
      'About use',
      name: 'disclaimerUsageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Any commercial activity anyone carries out with the Software, including paid distribution, bundled sales, or use as part of a commercial service, is unrelated to the Software's developers, who do not endorse, support, or guarantee it.\n\nYou are responsible for complying with the laws where you live, and you bear the consequences of any unlawful use of the Software.`
  String get disclaimerUsageContent {
    return Intl.message(
      'Any commercial activity anyone carries out with the Software, including paid distribution, bundled sales, or use as part of a commercial service, is unrelated to the Software\'s developers, who do not endorse, support, or guarantee it.\n\nYou are responsible for complying with the laws where you live, and you bear the consequences of any unlawful use of the Software.',
      name: 'disclaimerUsageContent',
      desc: '',
      args: [],
    );
  }

  /// `Your responsibility`
  String get disclaimerResponsibilityTitle {
    return Intl.message(
      'Your responsibility',
      name: 'disclaimerResponsibilityTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are responsible for making sure that using the Software is lawful where you live, and you alone bear the legal responsibility for everything you do with it and its consequences.\n\nThe subscriptions, nodes, and configurations you import are your own choice. Whether their source is lawful, their content is safe, and their service is reliable is a matter between you and their providers.`
  String get disclaimerResponsibilityContent {
    return Intl.message(
      'You are responsible for making sure that using the Software is lawful where you live, and you alone bear the legal responsibility for everything you do with it and its consequences.\n\nThe subscriptions, nodes, and configurations you import are your own choice. Whether their source is lawful, their content is safe, and their service is reliable is a matter between you and their providers.',
      name: 'disclaimerResponsibilityContent',
      desc: '',
      args: [],
    );
  }

  /// `Third-party content`
  String get disclaimerThirdPartyTitle {
    return Intl.message(
      'Third-party content',
      name: 'disclaimerThirdPartyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscription links, configuration files, rule sets, scripts, external resources, and external links are all provided by third parties. The developers cannot and do not review or guarantee their legality, accuracy, security, or availability.\n\nAny data leak, financial loss, account ban, or other loss caused by third-party content is to be settled between you and the third party; the developers bear no responsibility for it.`
  String get disclaimerThirdPartyContent {
    return Intl.message(
      'Subscription links, configuration files, rule sets, scripts, external resources, and external links are all provided by third parties. The developers cannot and do not review or guarantee their legality, accuracy, security, or availability.\n\nAny data leak, financial loss, account ban, or other loss caused by third-party content is to be settled between you and the third party; the developers bear no responsibility for it.',
      name: 'disclaimerThirdPartyContent',
      desc: '',
      args: [],
    );
  }

  /// `No warranty`
  String get disclaimerWarrantyTitle {
    return Intl.message(
      'No warranty',
      name: 'disclaimerWarrantyTitle',
      desc: '',
      args: [],
    );
  }

  /// `The Software is provided "as is" and "as available", without warranty of any kind, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, non-infringement, uninterrupted availability, freedom from errors, or freedom from security vulnerabilities.\n\nThe developers do not guarantee that the Software will meet your needs or that it will run without interruption or error.`
  String get disclaimerWarrantyContent {
    return Intl.message(
      'The Software is provided "as is" and "as available", without warranty of any kind, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, non-infringement, uninterrupted availability, freedom from errors, or freedom from security vulnerabilities.\n\nThe developers do not guarantee that the Software will meet your needs or that it will run without interruption or error.',
      name: 'disclaimerWarrantyContent',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of liability`
  String get disclaimerLiabilityTitle {
    return Intl.message(
      'Limitation of liability',
      name: 'disclaimerLiabilityTitle',
      desc: '',
      args: [],
    );
  }

  /// `To the maximum extent permitted by applicable law, neither the developers nor any contributor shall be liable for any direct, indirect, incidental, special, punitive, or consequential damages arising from the use of or inability to use the Software, including but not limited to data loss, device damage, network failures, business interruption, lost profits, or any resulting legal dispute, even if advised of the possibility of such damages.`
  String get disclaimerLiabilityContent {
    return Intl.message(
      'To the maximum extent permitted by applicable law, neither the developers nor any contributor shall be liable for any direct, indirect, incidental, special, punitive, or consequential damages arising from the use of or inability to use the Software, including but not limited to data loss, device damage, network failures, business interruption, lost profits, or any resulting legal dispute, even if advised of the possibility of such damages.',
      name: 'disclaimerLiabilityContent',
      desc: '',
      args: [],
    );
  }

  /// `Data collection and privacy`
  String get disclaimerPrivacyTitle {
    return Intl.message(
      'Data collection and privacy',
      name: 'disclaimerPrivacyTitle',
      desc: '',
      args: [],
    );
  }

  /// `The Software does not collect or upload your subscription URLs, node details, configuration content, visited websites, connection records, traffic content, or logs. This data stays on your device and the developers have no access to it.\n\nThe Software only reaches the network when you use a feature that needs it, such as fetching the subscription URL you provided when updating a profile, or contacting GitHub when checking for updates.\n\nThe Software includes no analytics or crash reporting service on any platform.`
  String get disclaimerPrivacyContent {
    return Intl.message(
      'The Software does not collect or upload your subscription URLs, node details, configuration content, visited websites, connection records, traffic content, or logs. This data stays on your device and the developers have no access to it.\n\nThe Software only reaches the network when you use a feature that needs it, such as fetching the subscription URL you provided when updating a profile, or contacting GitHub when checking for updates.\n\nThe Software includes no analyt…26282 tokens truncated…ms',
      name: 'itemsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Name prefix`
  String get additionalPrefix {
    return Intl.message(
      'Name prefix',
      name: 'additionalPrefix',
      desc: '',
      args: [],
    );
  }

  /// `Name suffix`
  String get additionalSuffix {
    return Intl.message(
      'Name suffix',
      name: 'additionalSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Skip certificate verification`
  String get skipCertVerify {
    return Intl.message(
      'Skip certificate verification',
      name: 'skipCertVerify',
      desc: '',
      args: [],
    );
  }

  /// `IP version`
  String get ipVersion {
    return Intl.message('IP version', name: 'ipVersion', desc: '', args: []);
  }

  /// `Add filters`
  String get addFilters {
    return Intl.message('Add filters', name: 'addFilters', desc: '', args: []);
  }

  /// `{label}: {message}`
  String failedItem(Object label, Object message) {
    return Intl.message(
      '$label: $message',
      name: 'failedItem',
      desc: '',
      args: [label, message],
    );
  }

  /// `{count} items failed. Tap to view`
  String failedCount(Object count) {
    return Intl.message(
      '$count items failed. Tap to view',
      name: 'failedCount',
      desc: '',
      args: [count],
    );
  }

  /// `This file is not a config that can be imported`
  String get importConfigInvalid {
    return Intl.message(
      'This file is not a config that can be imported',
      name: 'importConfigInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Importing replaces the proxy groups, rules and settings this profile has now`
  String get importConfigReplaceTip {
    return Intl.message(
      'Importing replaces the proxy groups, rules and settings this profile has now',
      name: 'importConfigReplaceTip',
      desc: '',
      args: [],
    );
  }

  /// `Network name`
  String get networkName {
    return Intl.message(
      'Network name',
      name: 'networkName',
      desc: '',
      args: [],
    );
  }

  /// `Network secret`
  String get networkSecret {
    return Intl.message(
      'Network secret',
      name: 'networkSecret',
      desc: '',
      args: [],
    );
  }

  /// `Peers`
  String get peers {
    return Intl.message('Peers', name: 'peers', desc: '', args: []);
  }

  /// `Virtual IPv4`
  String get virtualIpv4 {
    return Intl.message(
      'Virtual IPv4',
      name: 'virtualIpv4',
      desc: '',
      args: [],
    );
  }

  /// `Hostname`
  String get hostname {
    return Intl.message('Hostname', name: 'hostname', desc: '', args: []);
  }

  /// `Exit nodes`
  String get exitNodes {
    return Intl.message('Exit nodes', name: 'exitNodes', desc: '', args: []);
  }

  /// `Cipher`
  String get cipher {
    return Intl.message('Cipher', name: 'cipher', desc: '', args: []);
  }

  /// `Protocol`
  String get protocol {
    return Intl.message('Protocol', name: 'protocol', desc: '', args: []);
  }

  /// `Protocol parameter`
  String get protocolParam {
    return Intl.message(
      'Protocol parameter',
      name: 'protocolParam',
      desc: '',
      args: [],
    );
  }

  /// `Obfuscation`
  String get obfs {
    return Intl.message('Obfuscation', name: 'obfs', desc: '', args: []);
  }

  /// `Obfuscation parameter`
  String get obfsParam {
    return Intl.message(
      'Obfuscation parameter',
      name: 'obfsParam',
      desc: '',
      args: [],
    );
  }

  /// `Obfuscation password`
  String get obfsPassword {
    return Intl.message(
      'Obfuscation password',
      name: 'obfsPassword',
      desc: '',
      args: [],
    );
  }

  /// `Obfuscation mode`
  String get obfsMode {
    return Intl.message(
      'Obfuscation mode',
      name: 'obfsMode',
      desc: '',
      args: [],
    );
  }

  /// `Obfuscation host`
  String get obfsHost {
    return Intl.message(
      'Obfuscation host',
      name: 'obfsHost',
      desc: '',
      args: [],
    );
  }

  /// `Plugin`
  String get plugin {
    return Intl.message('Plugin', name: 'plugin', desc: '', args: []);
  }

  /// `Plugin mode`
  String get pluginMode {
    return Intl.message('Plugin mode', name: 'pluginMode', desc: '', args: []);
  }

  /// `Plugin host`
  String get pluginHost {
    return Intl.message('Plugin host', name: 'pluginHost', desc: '', args: []);
  }

  /// `Plugin path`
  String get pluginPath {
    return Intl.message('Plugin path', name: 'pluginPath', desc: '', args: []);
  }

  /// `Plugin username`
  String get pluginUsername {
    return Intl.message(
      'Plugin username',
      name: 'pluginUsername',
      desc: '',
      args: [],
    );
  }

  /// `Plugin password`
  String get pluginPassword {
    return Intl.message(
      'Plugin password',
      name: 'pluginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Plugin cipher`
  String get pluginCipher {
    return Intl.message(
      'Plugin cipher',
      name: 'pluginCipher',
      desc: '',
      args: [],
    );
  }

  /// `Private key`
  String get privateKey {
    return Intl.message('Private key', name: 'privateKey', desc: '', args: []);
  }

  /// `Public key`
  String get publicKey {
    return Intl.message('Public key', name: 'publicKey', desc: '', args: []);
  }

  /// `Private key passphrase`
  String get privateKeyPassphrase {
    return Intl.message(
      'Private key passphrase',
      name: 'privateKeyPassphrase',
      desc: '',
      args: [],
    );
  }

  /// `Pre-shared key`
  String get preSharedKey {
    return Intl.message(
      'Pre-shared key',
      name: 'preSharedKey',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get secretKey {
    return Intl.message('Key', name: 'secretKey', desc: '', args: []);
  }

  /// `Transport`
  String get transport {
    return Intl.message('Transport', name: 'transport', desc: '', args: []);
  }

  /// `Upload bandwidth`
  String get uploadBandwidth {
    return Intl.message(
      'Upload bandwidth',
      name: 'uploadBandwidth',
      desc: '',
      args: [],
    );
  }

  /// `Download bandwidth`
  String get downloadBandwidth {
    return Intl.message(
      'Download bandwidth',
      name: 'downloadBandwidth',
      desc: '',
      args: [],
    );
  }

  /// `Protocol version`
  String get protocolVersion {
    return Intl.message(
      'Protocol version',
      name: 'protocolVersion',
      desc: '',
      args: [],
    );
  }

  /// `Port hopping`
  String get portHopping {
    return Intl.message(
      'Port hopping',
      name: 'portHopping',
      desc: '',
      args: [],
    );
  }

  /// `Hop interval`
  String get hopInterval {
    return Intl.message(
      'Hop interval',
      name: 'hopInterval',
      desc: '',
      args: [],
    );
  }

  /// `Congestion control`
  String get congestionControl {
    return Intl.message(
      'Congestion control',
      name: 'congestionControl',
      desc: '',
      args: [],
    );
  }

  /// `UDP relay mode`
  String get udpRelayMode {
    return Intl.message(
      'UDP relay mode',
      name: 'udpRelayMode',
      desc: '',
      args: [],
    );
  }

  /// `Allowed IPs`
  String get allowedIps {
    return Intl.message('Allowed IPs', name: 'allowedIps', desc: '', args: []);
  }

  /// `Remote DNS resolution`
  String get remoteDnsResolve {
    return Intl.message(
      'Remote DNS resolution',
      name: 'remoteDnsResolve',
      desc: '',
      args: [],
    );
  }

  /// `Client fingerprint`
  String get clientFingerprint {
    return Intl.message(
      'Client fingerprint',
      name: 'clientFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Request headers`
  String get requestHeaders {
    return Intl.message(
      'Request headers',
      name: 'requestHeaders',
      desc: '',
      args: [],
    );
  }

  /// `{transport} Headers`
  String transportHeaders(Object transport) {
    return Intl.message(
      '$transport Headers',
      name: 'transportHeaders',
      desc: '',
      args: [transport],
    );
  }

  /// `Required`
  String get required {
    return Intl.message('Required', name: 'required', desc: '', args: []);
  }

  /// `Age secret key`
  String get ageSecretKey {
    return Intl.message(
      'Age secret key',
      name: 'ageSecretKey',
      desc: '',
      args: [],
    );
  }

  /// `Encrypted profile`
  String get ageEncryptedProfile {
    return Intl.message(
      'Encrypted profile',
      name: 'ageEncryptedProfile',
      desc: '',
      args: [],
    );
  }

  /// `This profile is encrypted with age and needs an age secret key to decrypt`
  String get ageSecretKeyRequiredTip {
    return Intl.message(
      'This profile is encrypted with age and needs an age secret key to decrypt',
      name: 'ageSecretKeyRequiredTip',
      desc: '',
      args: [],
    );
  }

  /// `Holds the start button and can't be removed`
  String get currentOutboundDesc {
    return Intl.message(
      'Holds the start button and can\'t be removed',
      name: 'currentOutboundDesc',
      desc: '',
      args: [],
    );
  }

  /// `Running`
  String get running {
    return Intl.message('Running', name: 'running', desc: '', args: []);
  }

  /// `Root`
  String get root {
    return Intl.message('Root', name: 'root', desc: '', args: []);
  }

  /// `Not running`
  String get notRunning {
    return Intl.message('Not running', name: 'notRunning', desc: '', args: []);
  }

  /// `Peak {value}`
  String trafficPeak(Object value) {
    return Intl.message(
      'Peak $value',
      name: 'trafficPeak',
      desc: '',
      args: [value],
    );
  }

  /// `Total {value}`
  String trafficTotal(Object value) {
    return Intl.message(
      'Total $value',
      name: 'trafficTotal',
      desc: '',
      args: [value],
    );
  }

  /// `Quality`
  String get ipQualityShort {
    return Intl.message('Quality', name: 'ipQualityShort', desc: '', args: []);
  }

  /// `Unknown type`
  String get ipTypeUnknown {
    return Intl.message(
      'Unknown type',
      name: 'ipTypeUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Tap the icon to retry`
  String get tapIconToRetry {
    return Intl.message(
      'Tap the icon to retry',
      name: 'tapIconToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Traffic takeover`
  String get networkTakeover {
    return Intl.message(
      'Traffic takeover',
      name: 'networkTakeover',
      desc: '',
      args: [],
    );
  }

  /// `Port {port}`
  String portValue(Object port) {
    return Intl.message(
      'Port $port',
      name: 'portValue',
      desc: '',
      args: [port],
    );
  }

  /// `{count, plural, =1{1 issue} other{{count} issues}}`
  String serviceAbnormalCount(num count) {
    return Intl.plural(
      count,
      one: '1 issue',
      other: '$count issues',
      name: 'serviceAbnormalCount',
      desc: '',
      args: [count],
    );
  }

  /// `All available`
  String get serviceAllAvailable {
    return Intl.message(
      'All available',
      name: 'serviceAllAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Shown on the dashboard`
  String get serviceShownOnDashboard {
    return Intl.message(
      'Shown on the dashboard',
      name: 'serviceShownOnDashboard',
      desc: '',
      args: [],
    );
  }

  /// `{count} timed out`
  String groupTimeoutCount(Object count) {
    return Intl.message(
      '$count timed out',
      name: 'groupTimeoutCount',
      desc: '',
      args: [count],
    );
  }

  /// `groups`
  String get groupCountUnit {
    return Intl.message('groups', name: 'groupCountUnit', desc: '', args: []);
  }

  /// `{count, plural, =1{1 group} other{{count} groups}}`
  String groupCount(num count) {
    return Intl.plural(
      count,
      one: '1 group',
      other: '$count groups',
      name: 'groupCount',
      desc: '',
      args: [count],
    );
  }

  /// `Groups show up here once the core starts`
  String get proxyGroupsAfterStart {
    return Intl.message(
      'Groups show up here once the core starts',
      name: 'proxyGroupsAfterStart',
      desc: '',
      args: [],
    );
  }

  /// `used`
  String get usedShort {
    return Intl.message('used', name: 'usedShort', desc: '', args: []);
  }

  /// `Updated {time}`
  String profileUpdatedAt(Object time) {
    return Intl.message(
      'Updated $time',
      name: 'profileUpdatedAt',
      desc: '',
      args: [time],
    );
  }

  /// `Expires {date}, {days, plural, =1{1 day} other{{days} days}} left`
  String profileExpiresIn(Object date, num days) {
    return Intl.message(
      'Expires $date, ${Intl.plural(days, one: '1 day', other: '$days days')} left',
      name: 'profileExpiresIn',
      desc: '',
      args: [date, days],
    );
  }

  /// `{days, plural, =1{1 day left} other{{days} days left}}`
  String profileDaysLeft(num days) {
    return Intl.plural(
      days,
      one: '1 day left',
      other: '$days days left',
      name: 'profileDaysLeft',
      desc: '',
      args: [days],
    );
  }

  /// `Target`
  String get target {
    return Intl.message('Target', name: 'target', desc: '', args: []);
  }

  /// `Exit`
  String get outboundExit {
    return Intl.message('Exit', name: 'outboundExit', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Traffic`
  String get traffic {
    return Intl.message('Traffic', name: 'traffic', desc: '', args: []);
  }

  /// `Downloaded`
  String get totalDownload {
    return Intl.message(
      'Downloaded',
      name: 'totalDownload',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded`
  String get totalUpload {
    return Intl.message('Uploaded', name: 'totalUpload', desc: '', args: []);
  }

  /// `From`
  String get initiatorShort {
    return Intl.message('From', name: 'initiatorShort', desc: '', args: []);
  }

  /// `Result`
  String get result {
    return Intl.message('Result', name: 'result', desc: '', args: []);
  }

  /// `Took`
  String get elapsed {
    return Intl.message('Took', name: 'elapsed', desc: '', args: []);
  }

  /// `Connection stats`
  String get connectionStats {
    return Intl.message(
      'Connection stats',
      name: 'connectionStats',
      desc: '',
      args: [],
    );
  }

  /// `Live connections, recent requests and DNS queries`
  String get connectionStatsDesc {
    return Intl.message(
      'Live connections, recent requests and DNS queries',
      name: 'connectionStatsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Memory the app and the core use`
  String get memoryInfoDesc {
    return Intl.message(
      'Memory the app and the core use',
      name: 'memoryInfoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit dashboard`
  String get editDashboard {
    return Intl.message(
      'Edit dashboard',
      name: 'editDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Available to add`
  String get dashboardAddableSection {
    return Intl.message(
      'Available to add',
      name: 'dashboardAddableSection',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 SUB-RULE rule was dropped, since custom profiles do not support sub-rules} other{{label} SUB-RULE rules were dropped, since custom profiles do not support sub-rules}}`
  String customImportDroppedSubRules(num count, Object label) {
    return Intl.plural(
      count,
      one: '1 SUB-RULE rule was dropped, since custom profiles do not support sub-rules',
      other:
          '$label SUB-RULE rules were dropped, since custom profiles do not support sub-rules',
      name: 'customImportDroppedSubRules',
      desc: '',
      args: [count, label],
    );
  }

  /// `Auto-include`
  String get autoInclude {
    return Intl.message(
      'Auto-include',
      name: 'autoInclude',
      desc: '',
      args: [],
    );
  }

  /// `All referenced proxies`
  String get allReferencedProxies {
    return Intl.message(
      'All referenced proxies',
      name: 'allReferencedProxies',
      desc: '',
      args: [],
    );
  }

  /// `All referenced proxy providers`
  String get allReferencedProxyProviders {
    return Intl.message(
      'All referenced proxy providers',
      name: 'allReferencedProxyProviders',
      desc: '',
      args: [],
    );
  }

  /// `Clear DNS cache`
  String get clearDnsCache {
    return Intl.message(
      'Clear DNS cache',
      name: 'clearDnsCache',
      desc: '',
      args: [],
    );
  }

  /// `DNS cache cleared`
  String get dnsCacheCleared {
    return Intl.message(
      'DNS cache cleared',
      name: 'dnsCacheCleared',
      desc: '',
      args: [],
    );
  }

  /// `Failed to clear DNS cache`
  String get clearDnsCacheFailed {
    return Intl.message(
      'Failed to clear DNS cache',
      name: 'clearDnsCacheFailed',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Preferred`
  String get preferred {
    return Intl.message('Preferred', name: 'preferred', desc: '', args: []);
  }

  /// `Add to local proxies`
  String get addToLocalProxies {
    return Intl.message(
      'Add to local proxies',
      name: 'addToLocalProxies',
      desc: '',
      args: [],
    );
  }

  /// `Added {name} to local proxies`
  String addedToLocalProxies(Object name) {
    return Intl.message(
      'Added $name to local proxies',
      name: 'addedToLocalProxies',
      desc: '',
      args: [name],
    );
  }

  /// `{name} is already in local proxies`
  String alreadyInLocalProxies(Object name) {
    return Intl.message(
      '$name is already in local proxies',
      name: 'alreadyInLocalProxies',
      desc: '',
      args: [name],
    );
  }

  /// `MITM`
  String get mitm {
    return Intl.message('MITM', name: 'mitm', desc: '', args: []);
  }

  /// `HTTPS decryption`
  String get httpsDecryption {
    return Intl.message(
      'HTTPS decryption',
      name: 'httpsDecryption',
      desc: '',
      args: [],
    );
  }

  /// `HTTP capture`
  String get httpCapture {
    return Intl.message(
      'HTTP capture',
      name: 'httpCapture',
      desc: '',
      args: [],
    );
  }

  /// `Records requests to the hosts listed under Hostname, to view in connection details. Records stay in memory only.`
  String get httpCaptureDesc {
    return Intl.message(
      'Records requests to the hosts listed under Hostname, to view in connection details. Records stay in memory only.',
      name: 'httpCaptureDesc',
      desc: '',
      args: [],
    );
  }

  /// `No host is listed, so nothing is recorded. Add hosts under Hostname on the MITM page, or from the details of a connection.`
  String get httpCaptureNoHosts {
    return Intl.message(
      'No host is listed, so nothing is recorded. Add hosts under Hostname on the MITM page, or from the details of a connection.',
      name: 'httpCaptureNoHosts',
      desc: '',
      args: [],
    );
  }

  /// `Maximum records`
  String get httpCaptureLimit {
    return Intl.message(
      'Maximum records',
      name: 'httpCaptureLimit',
      desc: '',
      args: [],
    );
  }

  /// `The oldest records go first once this many are kept or they fill {memory} of memory. Each body keeps its first {body}.`
  String httpCaptureLimitDesc(Object memory, Object body) {
    return Intl.message(
      'The oldest records go first once this many are kept or they fill $memory of memory. Each body keeps its first $body.',
      name: 'httpCaptureLimitDesc',
      desc: '',
      args: [memory, body],
    );
  }

  /// `HTTP requests`
  String get httpRequests {
    return Intl.message(
      'HTTP requests',
      name: 'httpRequests',
      desc: '',
      args: [],
    );
  }

  /// `Requests made before capture was on, or since cleared, are not listed.`
  String get httpRequestsMissing {
    return Intl.message(
      'Requests made before capture was on, or since cleared, are not listed.',
      name: 'httpRequestsMissing',
      desc: '',
      args: [],
    );
  }

  /// `This request is no longer kept`
  String get httpRequestCleared {
    return Intl.message(
      'This request is no longer kept',
      name: 'httpRequestCleared',
      desc: '',
      args: [],
    );
  }

  /// `Capture is off`
  String get httpCaptureOff {
    return Intl.message(
      'Capture is off',
      name: 'httpCaptureOff',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get inProgress {
    return Intl.message('In progress', name: 'inProgress', desc: '', args: []);
  }

  /// `Method`
  String get method {
    return Intl.message('Method', name: 'method', desc: '', args: []);
  }

  /// `Original URL`
  String get originalUrl {
    return Intl.message(
      'Original URL',
      name: 'originalUrl',
      desc: '',
      args: [],
    );
  }

  /// `Time to first byte`
  String get timeToFirstByte {
    return Intl.message(
      'Time to first byte',
      name: 'timeToFirstByte',
      desc: '',
      args: [],
    );
  }

  /// `Request body`
  String get requestBody {
    return Intl.message(
      'Request body',
      name: 'requestBody',
      desc: '',
      args: [],
    );
  }

  /// `Response`
  String get response {
    return Intl.message('Response', name: 'response', desc: '', args: []);
  }

  /// `Response body`
  String get responseBody {
    return Intl.message(
      'Response body',
      name: 'responseBody',
      desc: '',
      args: [],
    );
  }

  /// `Response headers`
  String get responseHeaders {
    return Intl.message(
      'Response headers',
      name: 'responseHeaders',
      desc: '',
      args: [],
    );
  }

  /// `Matched rules`
  String get matchedRules {
    return Intl.message(
      'Matched rules',
      name: 'matchedRules',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message('Overview', name: 'overview', desc: '', args: []);
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: '', args: []);
  }

  /// `Copy as Base64`
  String get copyAsBase64 {
    return Intl.message(
      'Copy as Base64',
      name: 'copyAsBase64',
      desc: '',
      args: [],
    );
  }

  /// `Copy as cURL`
  String get copyAsCurl {
    return Intl.message('Copy as cURL', name: 'copyAsCurl', desc: '', args: []);
  }

  /// `Close connection`
  String get closeConnection {
    return Intl.message(
      'Close connection',
      name: 'closeConnection',
      desc: '',
      args: [],
    );
  }

  /// `Copy host`
  String get copyHost {
    return Intl.message('Copy host', name: 'copyHost', desc: '', args: []);
  }

  /// `Copy destination`
  String get copyDestination {
    return Intl.message(
      'Copy destination',
      name: 'copyDestination',
      desc: '',
      args: [],
    );
  }

  /// `Copy request`
  String get copyRequest {
    return Intl.message(
      'Copy request',
      name: 'copyRequest',
      desc: '',
      args: [],
    );
  }

  /// `Copy response`
  String get copyResponse {
    return Intl.message(
      'Copy response',
      name: 'copyResponse',
      desc: '',
      args: [],
    );
  }

  /// `Copy response body`
  String get copyResponseBody {
    return Intl.message(
      'Copy response body',
      name: 'copyResponseBody',
      desc: '',
      args: [],
    );
  }

  /// `Read as Protobuf without its schema: field numbers only, and the types are guesses.`
  String get httpBodyProtobufGuess {
    return Intl.message(
      'Read as Protobuf without its schema: field numbers only, and the types are guesses.',
      name: 'httpBodyProtobufGuess',
      desc: '',
      args: [],
    );
  }

  /// `Export HAR`
  String get exportHar {
    return Intl.message('Export HAR', name: 'exportHar', desc: '', args: []);
  }

  /// `Add a reject rule`
  String get mitmAddRejectRule {
    return Intl.message(
      'Add a reject rule',
      name: 'mitmAddRejectRule',
      desc: '',
      args: [],
    );
  }

  /// `Add a map local rule`
  String get mitmAddMapLocalRule {
    return Intl.message(
      'Add a map local rule',
      name: 'mitmAddMapLocalRule',
      desc: '',
      args: [],
    );
  }

  /// `Contains private data`
  String get httpExportPrivateTitle {
    return Intl.message(
      'Contains private data',
      name: 'httpExportPrivateTitle',
      desc: '',
      args: [],
    );
  }

  /// `A request can carry cookies, tokens, passwords and form contents. Check what you share, and with whom.`
  String get httpExportPrivate {
    return Intl.message(
      'A request can carry cookies, tokens, passwords and form contents. Check what you share, and with whom.',
      name: 'httpExportPrivate',
      desc: '',
      args: [],
    );
  }

  /// `This module is a Stash override, so the rule was copied for you to add by hand.`
  String get mitmRuleCopiedForStash {
    return Intl.message(
      'This module is a Stash override, so the rule was copied for you to add by hand.',
      name: 'mitmRuleCopiedForStash',
      desc: '',
      args: [],
    );
  }

  /// `Binary data`
  String get binaryData {
    return Intl.message('Binary data', name: 'binaryData', desc: '', args: []);
  }

  /// `Not recorded while memory was short.`
  String get httpBodyNotKept {
    return Intl.message(
      'Not recorded while memory was short.',
      name: 'httpBodyNotKept',
      desc: '',
      args: [],
    );
  }

  /// `Only the start of this body was recorded.`
  String get httpBodyTruncated {
    return Intl.message(
      'Only the start of this body was recorded.',
      name: 'httpBodyTruncated',
      desc: '',
      args: [],
    );
  }

  /// `Could not decode {encoding}, so this is the data as it was sent.`
  String httpBodyUndecoded(Object encoding) {
    return Intl.message(
      'Could not decode $encoding, so this is the data as it was sent.',
      name: 'httpBodyUndecoded',
      desc: '',
      args: [encoding],
    );
  }

  /// `FlClash will be able to read everything sent to the decrypted hosts, cookies and passwords included. Turn this on only for hosts you mean to rewrite.`
  String get mitmEnableTip {
    return Intl.message(
      'FlClash will be able to read everything sent to the decrypted hosts, cookies and passwords included. Turn this on only for hosts you mean to rewrite.',
      name: 'mitmEnableTip',
      desc: '',
      args: [],
    );
  }

  /// `Certificate`
  String get certificate {
    return Intl.message('Certificate', name: 'certificate', desc: '', args: []);
  }

  /// `Generate certificate`
  String get generateCertificate {
    return Intl.message(
      'Generate certificate',
      name: 'generateCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Regenerate certificate`
  String get regenerateCertificate {
    return Intl.message(
      'Regenerate certificate',
      name: 'regenerateCertificate',
      desc: '',
      args: [],
    );
  }

  /// `The new certificate replaces the current one, which FlClash takes out of this device's trusted roots where it can. Every other device that trusts the current one has to install the new one.`
  String get regenerateCertificateTip {
    return Intl.message(
      'The new certificate replaces the current one, which FlClash takes out of this device\'s trusted roots where it can. Every other device that trusts the current one has to install the new one.',
      name: 'regenerateCertificateTip',
      desc: '',
      args: [],
    );
  }

  /// `Export certificate`
  String get exportCertificate {
    return Intl.message(
      'Export certificate',
      name: 'exportCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Install to system`
  String get installCertificate {
    return Intl.message(
      'Install to system',
      name: 'installCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Certificate installed`
  String get installCertificateSuccess {
    return Intl.message(
      'Certificate installed',
      name: 'installCertificateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Valid until {date}`
  String validUntil(Object date) {
    return Intl.message(
      'Valid until $date',
      name: 'validUntil',
      desc: '',
      args: [date],
    );
  }

  /// `Export it and trust it on the devices you want to decrypt.`
  String get mitmCertificateExportTip {
    return Intl.message(
      'Export it and trust it on the devices you want to decrypt.',
      name: 'mitmCertificateExportTip',
      desc: '',
      args: [],
    );
  }

  /// `Trusted`
  String get mitmTrustReady {
    return Intl.message('Trusted', name: 'mitmTrustReady', desc: '', args: []);
  }

  /// `Not fully trusted`
  String get mitmTrustUntrusted {
    return Intl.message(
      'Not fully trusted',
      name: 'mitmTrustUntrusted',
      desc: '',
      args: [],
    );
  }

  /// `Not installed`
  String get mitmTrustNotInstalled {
    return Intl.message(
      'Not installed',
      name: 'mitmTrustNotInstalled',
      desc: '',
      args: [],
    );
  }

  /// `Checking…`
  String get mitmTrustChecking {
    return Intl.message(
      'Checking…',
      name: 'mitmTrustChecking',
      desc: '',
      args: [],
    );
  }

  /// `Trust certificate`
  String get trustCertificate {
    return Intl.message(
      'Trust certificate',
      name: 'trustCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Only apps that trust user certificates, mostly browsers, are decrypted.`
  String get mitmCertificateAndroidReadyTip {
    return Intl.message(
      'Only apps that trust user certificates, mostly browsers, are decrypted.',
      name: 'mitmCertificateAndroidReadyTip',
      desc: '',
      args: [],
    );
  }

  /// `Flatpak browsers need the exported certificate imported by hand.`
  String get mitmCertificateLinuxTip {
    return Intl.message(
      'Flatpak browsers need the exported certificate imported by hand.',
      name: 'mitmCertificateLinuxTip',
      desc: '',
      args: [],
    );
  }

  /// `Chrome and Firefox keep their own certificate stores, which need certutil: {command}`
  String mitmCertutilMissing(Object command) {
    return Intl.message(
      'Chrome and Firefox keep their own certificate stores, which need certutil: $command',
      name: 'mitmCertutilMissing',
      desc: '',
      args: [command],
    );
  }

  /// `Not yet in: {stores}`
  String mitmMissingStores(Object stores) {
    return Intl.message(
      'Not yet in: $stores',
      name: 'mitmMissingStores',
      desc: '',
      args: [stores],
    );
  }

  /// `Adding the certificate to the system's trusted roots failed`
  String get mitmSystemStoreFailed {
    return Intl.message(
      'Adding the certificate to the system\'s trusted roots failed',
      name: 'mitmSystemStoreFailed',
      desc: '',
      args: [],
    );
  }

  /// `No Magisk, KernelSU or APatch was found to keep the certificate. Install it again after the device restarts.`
  String get mitmRootUntilReboot {
    return Intl.message(
      'No Magisk, KernelSU or APatch was found to keep the certificate. Install it again after the device restarts.',
      name: 'mitmRootUntilReboot',
      desc: '',
      args: [],
    );
  }

  /// `The certificate takes effect after the device restarts.`
  String get mitmRootPendingReboot {
    return Intl.message(
      'The certificate takes effect after the device restarts.',
      name: 'mitmRootPendingReboot',
      desc: '',
      args: [],
    );
  }

  /// `Root was found, so the certificate goes into the system's trusted certificates as a FlClash MITM CA module for Magisk, KernelSU or APatch. Every app on this device will then trust it, and anyone holding its private key could decrypt this device's HTTPS traffic. To undo it, regenerate the certificate or remove the module in the root manager and restart. If root is denied, it is installed as a user certificate instead.`
  String get mitmInstallSystemCaTip {
    return Intl.message(
      'Root was found, so the certificate goes into the system\'s trusted certificates as a FlClash MITM CA module for Magisk, KernelSU or APatch. Every app on this device will then trust it, and anyone holding its private key could decrypt this device\'s HTTPS traffic. To undo it, regenerate the certificate or remove the module in the root manager and restart. If root is denied, it is installed as a user certificate instead.',
      name: 'mitmInstallSystemCaTip',
      desc: '',
      args: [],
    );
  }

  /// `No root was found, so the certificate can only be installed as a user certificate. Only apps that trust user certificates, mostly browsers, are decrypted; other apps fail on the hosts you list, so leave those hosts out. On Android 11 and later you finish the install yourself in system settings.`
  String get mitmInstallUserCaTip {
    return Intl.message(
      'No root was found, so the certificate can only be installed as a user certificate. Only apps that trust user certificates, mostly browsers, are decrypted; other apps fail on the hosts you list, so leave those hosts out. On Android 11 and later you finish the install yourself in system settings.',
      name: 'mitmInstallUserCaTip',
      desc: '',
      args: [],
    );
  }

  /// `Saved {fileName} to Downloads. Install it in Settings under Security › Encryption & credentials › Install a certificate › CA certificate.`
  String mitmCertificateSavedTip(Object fileName) {
    return Intl.message(
      'Saved $fileName to Downloads. Install it in Settings under Security › Encryption & credentials › Install a certificate › CA certificate.',
      name: 'mitmCertificateSavedTip',
      desc: '',
      args: [fileName],
    );
  }

  /// `Open settings`
  String get openSettings {
    return Intl.message(
      'Open settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Remove the old certificate, {name}, in Settings under Security › Encryption & credentials › Trusted credentials › User, then install the new one.`
  String mitmRemoveOldCertificateTip(Object name) {
    return Intl.message(
      'Remove the old certificate, $name, in Settings under Security › Encryption & credentials › Trusted credentials › User, then install the new one.',
      name: 'mitmRemoveOldCertificateTip',
      desc: '',
      args: [name],
    );
  }

  /// `The old certificate, {name}, could not be removed. Remove it from the trusted roots yourself.`
  String mitmOldCertificateLeftTip(Object name) {
    return Intl.message(
      'The old certificate, $name, could not be removed. Remove it from the trusted roots yourself.',
      name: 'mitmOldCertificateLeftTip',
      desc: '',
      args: [name],
    );
  }

  /// `The old certificate, {name}, is still among the system's trusted CAs. Allow FlClash root access in your root manager and regenerate, or remove the FlClash MITM CA module there and restart.`
  String mitmOldSystemCertificateLeftTip(Object name) {
    return Intl.message(
      'The old certificate, $name, is still among the system\'s trusted CAs. Allow FlClash root access in your root manager and regenerate, or remove the FlClash MITM CA module there and restart.',
      name: 'mitmOldSystemCertificateLeftTip',
      desc: '',
      args: [name],
    );
  }

  /// `Decrypt this host`
  String get mitmDecryptHost {
    return Intl.message(
      'Decrypt this host',
      name: 'mitmDecryptHost',
      desc: '',
      args: [],
    );
  }

  /// `Add {host} to the hostname list? FlClash can then read what is sent to it, cookies and passwords included.`
  String mitmDecryptHostTip(Object host) {
    return Intl.message(
      'Add $host to the hostname list? FlClash can then read what is sent to it, cookies and passwords included.',
      name: 'mitmDecryptHostTip',
      desc: '',
      args: [host],
    );
  }

  /// `The client refused the certificate. Install the CA, or exclude this host if the app pins its certificate.`
  String get mitmClientRefusedCertificate {
    return Intl.message(
      'The client refused the certificate. Install the CA, or exclude this host if the app pins its certificate.',
      name: 'mitmClientRefusedCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Exclude from decryption`
  String get mitmExcludeHost {
    return Intl.message(
      'Exclude from decryption',
      name: 'mitmExcludeHost',
      desc: '',
      args: [],
    );
  }

  /// `Add -{host} to the top of the hostname list? The host is then never decrypted.`
  String mitmExcludeHostTip(Object host) {
    return Intl.message(
      'Add -$host to the top of the hostname list? The host is then never decrypted.',
      name: 'mitmExcludeHostTip',
      desc: '',
      args: [host],
    );
  }

  /// `URL rewrite`
  String get urlRewrite {
    return Intl.message('URL rewrite', name: 'urlRewrite', desc: '', args: []);
  }

  /// `Header rewrite`
  String get headerRewrite {
    return Intl.message(
      'Header rewrite',
      name: 'headerRewrite',
      desc: '',
      args: [],
    );
  }

  /// `Body rewrite`
  String get bodyRewrite {
    return Intl.message(
      'Body rewrite',
      name: 'bodyRewrite',
      desc: '',
      args: [],
    );
  }

  /// `Map local`
  String get mapLocal {
    return Intl.message('Map local', name: 'mapLocal', desc: '', args: []);
  }

  /// `A leading - excludes a host, and the first match decides.`
  String get mitmHostnameDesc {
    return Intl.message(
      'A leading - excludes a host, and the first match decides.',
      name: 'mitmHostnameDesc',
      desc: '',
      args: [],
    );
  }

  /// `Modules`
  String get mitmModules {
    return Intl.message('Modules', name: 'mitmModules', desc: '', args: []);
  }

  /// `Module`
  String get mitmModule {
    return Intl.message('Module', name: 'mitmModule', desc: '', args: []);
  }

  /// `This is not a Surge module, a Loon plugin, a Quantumult X snippet or a Stash override`
  String get mitmModuleInvalid {
    return Intl.message(
      'This is not a Surge module, a Loon plugin, a Quantumult X snippet or a Stash override',
      name: 'mitmModuleInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Arguments`
  String get arguments {
    return Intl.message('Arguments', name: 'arguments', desc: '', args: []);
  }

  /// `Routing rules`
  String get mitmRoutingRules {
    return Intl.message(
      'Routing rules',
      name: 'mitmRoutingRules',
      desc: '',
      args: [],
    );
  }

  /// `Ignored lines`
  String get mitmIgnoredLines {
    return Intl.message(
      'Ignored lines',
      name: 'mitmIgnoredLines',
      desc: '',
      args: [],
    );
  }

  /// `Routing rules go in front of the profile’s own.`
  String get mitmModuleRulesDesc {
    return Intl.message(
      'Routing rules go in front of the profile’s own.',
      name: 'mitmModuleRulesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Written for {system}; some lines may not match apps on this device.`
  String mitmModuleSystemTip(Object system) {
    return Intl.message(
      'Written for $system; some lines may not match apps on this device.',
      name: 'mitmModuleSystemTip',
      desc: '',
      args: [system],
    );
  }

  /// `The [{section}] section is not supported`
  String mitmSkipSection(Object section) {
    return Intl.message(
      'The [$section] section is not supported',
      name: 'mitmSkipSection',
      desc: '',
      args: [section],
    );
  }

  /// `This setting is not supported`
  String get mitmSkipSetting {
    return Intl.message(
      'This setting is not supported',
      name: 'mitmSkipSetting',
      desc: '',
      args: [],
    );
  }

  /// `This script type is not supported`
  String get mitmSkipScriptType {
    return Intl.message(
      'This script type is not supported',
      name: 'mitmSkipScriptType',
      desc: '',
      args: [],
    );
  }

  /// `This rule type is not supported`
  String get mitmSkipRule {
    return Intl.message(
      'This rule type is not supported',
      name: 'mitmSkipRule',
      desc: '',
      args: [],
    );
  }

  /// `Only the DIRECT and REJECT policies are supported`
  String get mitmSkipPolicy {
    return Intl.message(
      'Only the DIRECT and REJECT policies are supported',
      name: 'mitmSkipPolicy',
      desc: '',
      args: [],
    );
  }

  /// `jq rewrites are not supported`
  String get mitmSkipJq {
    return Intl.message(
      'jq rewrites are not supported',
      name: 'mitmSkipJq',
      desc: '',
      args: [],
    );
  }

  /// `JSON body rewrites are not supported`
  String get mitmSkipJsonBody {
    return Intl.message(
      'JSON body rewrites are not supported',
      name: 'mitmSkipJsonBody',
      desc: '',
      args: [],
    );
  }

  /// `Rewriting all headers as one text is not supported`
  String get mitmSkipRawHeader {
    return Intl.message(
      'Rewriting all headers as one text is not supported',
      name: 'mitmSkipRawHeader',
      desc: '',
      args: [],
    );
  }

  /// `Conditional rewrites are not supported`
  String get mitmSkipConditional {
    return Intl.message(
      'Conditional rewrites are not supported',
      name: 'mitmSkipConditional',
      desc: '',
      args: [],
    );
  }

  /// `The file this line names is not attached; use a URL or attach it`
  String get mitmSkipRelativeData {
    return Intl.message(
      'The file this line names is not attached; use a URL or attach it',
      name: 'mitmSkipRelativeData',
      desc: '',
      args: [],
    );
  }

  /// `Its file has not been downloaded`
  String get mitmSkipNotDownloaded {
    return Intl.message(
      'Its file has not been downloaded',
      name: 'mitmSkipNotDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `This line cannot be read`
  String get mitmSkipUnreadable {
    return Intl.message(
      'This line cannot be read',
      name: 'mitmSkipUnreadable',
      desc: '',
      args: [],
    );
  }

  /// `Add a local file`
  String get mitmAddLocalFile {
    return Intl.message(
      'Add a local file',
      name: 'mitmAddLocalFile',
      desc: '',
      args: [],
    );
  }

  /// `New module`
  String get mitmNewModule {
    return Intl.message(
      'New module',
      name: 'mitmNewModule',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get mitmAttachments {
    return Intl.message(
      'Attachments',
      name: 'mitmAttachments',
      desc: '',
      args: [],
    );
  }

  /// `Lines refer to attachments by file name, as in script-path=a.js.`
  String get mitmAttachmentsDesc {
    return Intl.message(
      'Lines refer to attachments by file name, as in script-path=a.js.',
      name: 'mitmAttachmentsDesc',
      desc: '',
      args: [],
    );
  }

  /// `The file is larger than {size} MB`
  String mitmFileTooLarge(Object size) {
    return Intl.message(
      'The file is larger than $size MB',
      name: 'mitmFileTooLarge',
      desc: '',
      args: [size],
    );
  }

  /// `Turned off by an argument`
  String get mitmSkipDisabled {
    return Intl.message(
      'Turned off by an argument',
      name: 'mitmSkipDisabled',
      desc: '',
      args: [],
    );
  }

  /// `This event is not supported`
  String get mitmSkipEvent {
    return Intl.message(
      'This event is not supported',
      name: 'mitmSkipEvent',
      desc: '',
      args: [],
    );
  }

  /// `Run now`
  String get mitmRunScript {
    return Intl.message('Run now', name: 'mitmRunScript', desc: '', args: []);
  }

  /// `The script finished without output`
  String get mitmScriptNoOutput {
    return Intl.message(
      'The script finished without output',
      name: 'mitmScriptNoOutput',
      desc: '',
      args: [],
    );
  }

  /// `Run this module's scripts?`
  String get mitmScriptRiskTitle {
    return Intl.message(
      'Run this module\'s scripts?',
      name: 'mitmScriptRiskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Its scripts read and change the traffic of the hosts they match, cookies and tokens included, and can send requests of their own. Turn it on only if you trust where it comes from.`
  String get mitmScriptRisk {
    return Intl.message(
      'Its scripts read and change the traffic of the hosts they match, cookies and tokens included, and can send requests of their own. Turn it on only if you trust where it comes from.',
      name: 'mitmScriptRisk',
      desc: '',
      args: [],
    );
  }

  /// `{name} changed its scripts and was turned off`
  String mitmModuleScriptsChanged(Object name) {
    return Intl.message(
      '$name changed its scripts and was turned off',
      name: 'mitmModuleScriptsChanged',
      desc: '',
      args: [name],
    );
  }

  /// `Skip server certificate verification`
  String get skipServerCertVerify {
    return Intl.message(
      'Skip server certificate verification',
      name: 'skipServerCertVerify',
      desc: '',
      args: [],
    );
  }

  /// `Block QUIC`
  String get blockQuic {
    return Intl.message('Block QUIC', name: 'blockQuic', desc: '', args: []);
  }

  /// `HTTP/2`
  String get http2 {
    return Intl.message('HTTP/2', name: 'http2', desc: '', args: []);
  }

  /// `Decrypt without local trust`
  String get decryptUntrusted {
    return Intl.message(
      'Decrypt without local trust',
      name: 'decryptUntrusted',
      desc: '',
      args: [],
    );
  }

  /// `{invalid} of {total} invalid`
  String invalidOfCount(Object invalid, Object total) {
    return Intl.message(
      '$invalid of $total invalid',
      name: 'invalidOfCount',
      desc: '',
      args: [invalid, total],
    );
  }

  /// `One item per line`
  String get batchLineInputTip {
    return Intl.message(
      'One item per line',
      name: 'batchLineInputTip',
      desc: '',
      args: [],
    );
  }

  /// `Downloading update`
  String get downloadingUpdate {
    return Intl.message(
      'Downloading update',
      name: 'downloadingUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get updateFailed {
    return Intl.message(
      'Update failed',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Update download test`
  String get updateDownloadTest {
    return Intl.message(
      'Update download test',
      name: 'updateDownloadTest',
      desc: '',
      args: [],
    );
  }

  /// `Downloading the update. Follow its progress on the dashboard.`
  String get updateDownloadStarted {
    return Intl.message(
      'Downloading the update. Follow its progress on the dashboard.',
      name: 'updateDownloadStarted',
      desc: '',
      args: [],
    );
  }

  /// `Update ready`
  String get updateReady {
    return Intl.message(
      'Update ready',
      name: 'updateReady',
      desc: '',
      args: [],
    );
  }

  /// `The update has downloaded. Tap to install it.`
  String get updateReadyTip {
    return Intl.message(
      'The update has downloaded. Tap to install it.',
      name: 'updateReadyTip',
      desc: '',
      args: [],
    );
  }

  /// `Stop downloading the update?`
  String get stopUpdateDownloadTip {
    return Intl.message(
      'Stop downloading the update?',
      name: 'stopUpdateDownloadTip',
      desc: '',
      args: [],
    );
  }

  /// `The update could not be installed. You can download it from the release page instead.`
  String get updateInstallFailed {
    return Intl.message(
      'The update could not be installed. You can download it from the release page instead.',
      name: 'updateInstallFailed',
      desc: '',
      args: [],
    );
  }

  /// `The downloaded update could not be verified.`
  String get updateNotVerified {
    return Intl.message(
      'The downloaded update could not be verified.',
      name: 'updateNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `FlClash closes to install the update and opens again when it is done.`
  String get updateRestartTip {
    return Intl.message(
      'FlClash closes to install the update and opens again when it is done.',
      name: 'updateRestartTip',
      desc: '',
      args: [],
    );
  }

  /// `The update could not be downloaded.`
  String get updateDownloadFailed {
    return Intl.message(
      'The update could not be downloaded.',
      name: 'updateDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Resolves the hostnames of the other DNS servers. Use IP addresses only.`
  String get defaultNameserverDesc {
    return Intl.message(
      'Resolves the hostnames of the other DNS servers. Use IP addresses only.',
      name: 'defaultNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `The default DNS servers, such as 223.5.5.5, tls://1.1.1.1 or https://dns.google/dns-query.`
  String get nameserverDesc {
    return Intl.message(
      'The default DNS servers, such as 223.5.5.5, tls://1.1.1.1 or https://dns.google/dns-query.',
      name: 'nameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Used instead of Nameserver when the fallback filter treats its answer as polluted.`
  String get fallbackDesc {
    return Intl.message(
      'Used instead of Nameserver when the fallback filter treats its answer as polluted.',
      name: 'fallbackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resolves proxy server hostnames only.`
  String get proxyServerNameserverDesc {
    return Intl.message(
      'Resolves proxy server hostnames only.',
      name: 'proxyServerNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Matching proxy server hostnames use the DNS server given here instead of Proxy Server Nameserver.`
  String get proxyServerNameserverPolicyDesc {
    return Intl.message(
      'Matching proxy server hostnames use the DNS server given here instead of Proxy Server Nameserver.',
      name: 'proxyServerNameserverPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Resolves domains for connections that go direct.`
  String get directNameserverDesc {
    return Intl.message(
      'Resolves domains for connections that go direct.',
      name: 'directNameserverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Matching domains use the DNS server given here instead of Nameserver and Fallback.`
  String get nameserverPolicyDesc {
    return Intl.message(
      'Matching domains use the DNS server given here instead of Nameserver and Fallback.',
      name: 'nameserverPolicyDesc',
      desc: '',
      args: [],
    );
  }

  /// `These domains get real IPs instead of Fake-IPs. In whitelist mode, only they get Fake-IPs.`
  String get fakeipFilterDesc {
    return Intl.message(
      'These domains get real IPs instead of Fake-IPs. In whitelist mode, only they get Fake-IPs.',
      name: 'fakeipFilterDesc',
      desc: '',
      args: [],
    );
  }

  /// `Domains in these GeoSite categories are resolved by Fallback directly.`
  String get fallbackFilterGeositeDesc {
    return Intl.message(
      'Domains in these GeoSite categories are resolved by Fallback directly.',
      name: 'fallbackFilterGeositeDesc',
      desc: '',
      args: [],
    );
  }

  /// `When Nameserver returns an IP in these ranges, the Fallback answer is used.`
  String get fallbackFilterIpcidrDesc {
    return Intl.message(
      'When Nameserver returns an IP in these ranges, the Fallback answer is used.',
      name: 'fallbackFilterIpcidrDesc',
      desc: '',
      args: [],
    );
  }

  /// `These domains are resolved by Fallback directly.`
  String get fallbackFilterDomainDesc {
    return Intl.message(
      'These domains are resolved by Fallback directly.',
      name: 'fallbackFilterDomainDesc',
      desc: '',
      args: [],
    );
  }

  /// `HeySocks account`
  String get heysocksAccount {
    return Intl.message(
      'HeySocks account',
      name: 'heysocksAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get heysocksEmail {
    return Intl.message('Email', name: 'heysocksEmail', desc: '', args: []);
  }

  /// `Sign in`
  String get heysocksLogin {
    return Intl.message('Sign in', name: 'heysocksLogin', desc: '', args: []);
  }

  /// `Sign out`
  String get heysocksLogout {
    return Intl.message('Sign out', name: 'heysocksLogout', desc: '', args: []);
  }

  /// `Sign in again`
  String get heysocksRelogin {
    return Intl.message(
      'Sign in again',
      name: 'heysocksRelogin',
      desc: '',
      args: [],
    );
  }

  /// `Signed in`
  String get heysocksSignedIn {
    return Intl.message(
      'Signed in',
      name: 'heysocksSignedIn',
      desc: '',
      args: [],
    );
  }

  /// `Not signed in`
  String get heysocksSignedOut {
    return Intl.message(
      'Not signed in',
      name: 'heysocksSignedOut',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to load the countries and lines available to your account.`
  String get heysocksLoginHint {
    return Intl.message(
      'Sign in to load the countries and lines available to your account.',
      name: 'heysocksLoginHint',
      desc: '',
      args: [],
    );
  }

  /// `Authorize with another device`
  String get heysocksDevice {
    return Intl.message(
      'Authorize with another device',
      name: 'heysocksDevice',
      desc: '',
      args: [],
    );
  }

  /// `Enter this code in the device authorization page of your signed-in HeySocks account.`
  String get heysocksDeviceHint {
    return Intl.message(
      'Enter this code in the device authorization page of your signed-in HeySocks account.',
      name: 'heysocksDeviceHint',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for authorization…`
  String get heysocksWaiting {
    return Intl.message(
      'Waiting for authorization…',
      name: 'heysocksWaiting',
      desc: '',
      args: [],
    );
  }

  /// `Account verification`
  String get heysocksVerification {
    return Intl.message(
      'Account verification',
      name: 'heysocksVerification',
      desc: '',
      args: [],
    );
  }

  /// `Syncing lines…`
  String get heysocksSyncing {
    return Intl.message(
      'Syncing lines…',
      name: 'heysocksSyncing',
      desc: '',
      args: [],
    );
  }

  /// `{completed} of {total} checked`
  String heysocksProgress(Object completed, Object total) {
    return Intl.message(
      '$completed of $total checked',
      name: 'heysocksProgress',
      desc: '',
      args: [completed, total],
    );
  }

  /// `Available lines`
  String get heysocksReady {
    return Intl.message(
      'Available lines',
      name: 'heysocksReady',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported lines`
  String get heysocksUnsupported {
    return Intl.message(
      'Unsupported lines',
      name: 'heysocksUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `Failed updates`
  String get heysocksFailed {
    return Intl.message(
      'Failed updates',
      name: 'heysocksFailed',
      desc: '',
      args: [],
    );
  }

  /// `Choose a country and line`
  String get heysocksChoose {
    return Intl.message(
      'Choose a country and line',
      name: 'heysocksChoose',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your HeySocks account before connecting.`
  String get heysocksLoginRequired {
    return Intl.message(
      'Sign in to your HeySocks account before connecting.',
      name: 'heysocksLoginRequired',
      desc: '',
      args: [],
    );
  }

  /// `The selected line is unavailable. Choose a country and line to continue.`
  String get heysocksSelectionRequired {
    return Intl.message(
      'The selected line is unavailable. Choose a country and line to continue.',
      name: 'heysocksSelectionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Authorization expired. Please try again.`
  String get heysocksExpired {
    return Intl.message(
      'Authorization expired. Please try again.',
      name: 'heysocksExpired',
      desc: '',
      args: [],
    );
  }

  /// `Unable to reach HeySocks. Check your connection and retry.`
  String get heysocksNetworkError {
    return Intl.message(
      'Unable to reach HeySocks. Check your connection and retry.',
      name: 'heysocksNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Unable to save the account securely. Please try again.`
  String get heysocksStorageError {
    return Intl.message(
      'Unable to save the account securely. Please try again.',
      name: 'heysocksStorageError',
      desc: '',
      args: [],
    );
  }

  /// `Check your email and password, then try again.`
  String get heysocksInvalidLogin {
    return Intl.message(
      'Check your email and password, then try again.',
      name: 'heysocksInvalidLogin',
      desc: '',
      args: [],
    );
  }

  /// `The account operation failed. Please try again.`
  String get heysocksError {
    return Intl.message(
      'The account operation failed. Please try again.',
      name: 'heysocksError',
      desc: '',
      args: [],
    );
  }

  /// `Account-managed connection details cannot be exported.`
  String get heysocksPrivateProfile {
    return Intl.message(
      'Account-managed connection details cannot be exported.',
      name: 'heysocksPrivateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Open the app to refresh your HeySocks account before connecting.`
  String get heysocksOpenApp {
    return Intl.message(
      'Open the app to refresh your HeySocks account before connecting.',
      name: 'heysocksOpenApp',
      desc: '',
      args: [],
    );
  }

  /// `Some lines could not be updated. The last valid settings are retained.`
  String get heysocksPartial {
    return Intl.message(
      'Some lines could not be updated. The last valid settings are retained.',
      name: 'heysocksPartial',
      desc: '',
      args: [],
    );
  }

  /// `While the app is open and the proxy is running, the current line is checked every 45 seconds. Two failed checks prompt you to switch.`
  String get heysocksHealthHint {
    return Intl.message(
      'While the app is open and the proxy is running, the current line is checked every 45 seconds. Two failed checks prompt you to switch.',
      name: 'heysocksHealthHint',
      desc: '',
      args: [],
    );
  }

  /// `The current line is not responding. Tap to choose another line.`
  String get heysocksUnresponsive {
    return Intl.message(
      'The current line is not responding. Tap to choose another line.',
      name: 'heysocksUnresponsive',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
