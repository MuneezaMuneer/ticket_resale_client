import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyText {
  static const String privacyPolicy = '1. Introduction\n\n'
      ' Thank you for choosing our RaveTrade App. This Privacy Policy is designed to inform you about how we collect, use, and safeguard your personal information. By using our app, you agree to the terms outlined in this policy.'
      '2. Information We Collect\n\n'
      'We collect a minimal amount of information, limited to the name of the user for identification within the app. This data is solely utilized for personalization and user account management.'
      '3. How We Use Your Information\n\n'
      'We use the collected information to:\n\n'
      '- Provide and personalize our services.\n'
      '- Enhance your user experience within the app.\n\n'
      '4. Data Security\n\n'
      'We prioritize the security of your information. We employ industry-standard measures to protect against unauthorized access, disclosure, alteration, and destruction of data.\n\n'
      '5. Third-Party Services\n\n'
      'Our app does not integrate with any third-party services. All data is kept within the app and is not shared with external entities.\n\n'
      '6. Children\'s Privacy\n\n'
      'Our app is not directed at individuals under the age of 13. We do not knowingly collect personal information from children. If you believe a child has provided us with information, please contact us.\n\n'
      '7. Changes to this Privacy Policy\n\n'
      'We reserve the right to update this Privacy Policy periodically. Changes will be effective upon posting, so we recommend checking this page regularly for updates.\n\n'
      '8. Your Choices\n\n'
      'You can manage your privacy preferences within the app settings. You also have the right to request access, correction, or deletion of your personal information.\n\n'
      '9. Contact Us\n\n'
      'For any privacy-related inquiries, please contact us at [Client Contact Email/Phone].\n\n'
      '10. Governing Law\n\n'
      'This Privacy Policy is governed by and construed in accordance with the laws of the United States.\n\n'
      'Last Updated: 5 Feb, 2024';
}

class TermOfUseText {
  static const String termOfUse = '1. Acceptance of Terms\n\n'
      'By downloading, installing, or using the RaveTrade App, you agree to comply with these Terms of Use. If you do not agree, please refrain from using the app.'
      '2. User Eligibility\n\n'
      'You must be at least 13 years old to use the app. If you are under 13, you may only use the app with the consent of a parent or legal guardian.\n\n'
      '3. License to Use\n\n'
      'Subject to compliance with these Terms, we grant you a limited, non-exclusive, non-transferable license to use the app for personal, non-commercial purposes.\n\n'
      '4. User Responsibilities\n\n'
      'You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. Notify us immediately of any unauthorized use.\n\n'
      '5. Prohibited Conduct\n\n'
      'You agree not to:\n'
      '- Violate any applicable laws or regulations.\n'
      '- Interfere with or disrupt the app\'s functionality.\n'
      '- Attempt to gain unauthorized access to the app.\n\n'
      '6. Intellectual Property\n\n'
      'All content, trademarks, and intellectual property within the app are owned or licensed by us. You may not reproduce, distribute, or modify any part of the app without our explicit consent.\n\n'
      '7. Limitation of Liability\n\n'
      'To the maximum extent permitted by law, we shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of the app.\n\n'
      '8. Privacy Policy\n\n'
      'Your use of the app is also governed by our Privacy Policy. Please review it to understand how we collect, use, and safeguard your information.\n\n'
      '9. Governing Law\n\n'
      'These Terms are governed by and construed in accordance with the laws of the United States.\n\n'
      '10. Changes to Terms\n\n'
      'We reserve the right to modify these Terms of Use at any time. Changes will be effective upon posting, and your continued use of the app constitutes acceptance of the modified terms.\n\n'
      'Last Updated: 5 Feb, 2024\n\n';
}

class AppText {
  static SharedPreferences? preference;
  static const isAdminPrefKey = 'isAdmin';
  static const admin = 'admin';
  static const client = 'client';
}
