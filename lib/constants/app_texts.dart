import 'package:shared_preferences/shared_preferences.dart';

class AppText {
  static SharedPreferences? preference;
  static const isAdminPrefKey = 'isAdmin';
  static const admin = 'admin';
  static const client = 'client';

  static const String privacyPolicy = """
Privacy Policy for Rave Trade LLC

Last Updated: 19 Apr, 2024

Rave Trade LLC ("Rave Trade," "we," "us," or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information when you use our mobile application and any related services (collectively, the "Services"). By accessing or using our Services, you consent to the practices described in this Privacy Policy.

1. Information We Collect
   1.1 Personal Information: When you create an account, we may collect personal information such as your name, email address, date of birth, phone number, and profile image. If you are a seller, we may also collect your PayPal email address and government-issued ID for verification purposes.
   1.2 Transaction Information: When you buy or sell tickets on our platform, we may collect information related to the transaction, such as the ticket details, price, and communication between buyers and sellers.
   1.3 Usage Information: We may collect information about how you access and use our Services, including your IP address, device information, browser type, and referring/exit pages.
   1.4 Cookies and Similar Technologies: We may use cookies and similar tracking technologies to enhance your experience and gather information about how you use our Services.

2. How We Use Your Information
   2.1 Provide and Improve Our Services: We use your information to provide, maintain, and improve our Services, including processing transactions, verifying user identities, and ensuring the security of our platform.
   2.2 Communication: We may use your information to communicate with you about your account, transactions, and updates to our Services.
   2.3 Fraud Prevention: We may use your information to prevent, detect, and investigate potential fraud, scams, or other illegal activities.
   2.4 Legal Compliance: We may use your information to comply with applicable laws, regulations, or legal processes.

3. How We Share Your Information
   3.1 No Sale or Sharing of Personal Information: We do not sell, trade, or otherwise transfer your personal information to third parties for their marketing purposes.
   3.2 Service Providers: We may share your information with third-party service providers who assist us in operating our Services, such as hosting, analytics, and customer support. These service providers are contractually obligated to maintain the confidentiality and security of your information.
   3.3 Legal Requirements: We may disclose your information if required to do so by law or in response to valid requests by public authorities (e.g., a court or government agency).
   3.4 Business Transfers: If we are involved in a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred as part of that transaction. We will notify you via email and/or a prominent notice on our Services of any change in ownership or use of your information.

4. Your Choices and Rights
   4.1 Account Information: You may update, correct, or delete your account information at any time by logging into your account and updating your profile.
   4.2 Cookies: You may disable cookies through your browser settings, but this may affect your ability to use certain features of our Services.
   4.3 Marketing Communications: You may opt-out of receiving marketing communications from us by following the unsubscribe instructions provided in such communications.
   4.4 Data Subject Rights: Depending on your location, you may have certain rights under applicable data protection laws, such as the right to access, correct, or delete your personal information. To exercise these rights, please contact us using the information provided below.

5. Data Security
   We implement reasonable security measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

6. Data Retention
   We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.

7. Children's Privacy
   Our Services are not intended for use by children under the age of 18. We do not knowingly collect personal information from children under 18. If we learn that we have collected personal information from a child under 18, we will take steps to delete such information as soon as possible.

8. Changes to This Privacy Policy
   We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date at the top of this Privacy Policy. Your continued use of our Services after any changes to this Privacy Policy constitutes your acceptance of the new Privacy Policy.

9. Contact Us
   If you have any questions, concerns, or requests regarding this Privacy Policy or our privacy practices, please contact us at:

   Rave Trade LLC
   1420 NE Miami PL PT 1907
   Miami, FL 33132
   plur@ravetradeapp.com

By using our Services, you acknowledge that you have read, understood, and agree to the terms of this Privacy Policy.
""";

  static const String termOfUse = """
Terms of Use for Rave Trade LLC

Last Updated: April 18, 2024

Welcome to Rave Trade LLC ("Rave Trade," "we," "us," or "our"), a ticket reselling platform that connects buyers and sellers of music festival tickets. These Terms of Use ("Terms") govern your access to and use of our mobile application and any related services (collectively, the "Services"). By accessing or using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, do not use our Services.

1. User Accounts
   1.1 Registration: To access certain features of our Services, you must register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information as necessary.
   1.2 Eligibility: You must be at least 18 years old to create an account. By creating an account, you represent and warrant that you are at least 18 years old and have the legal capacity to enter into these Terms.
   1.3 Account Security: You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.
   1.4 Verification: We use a Know Your Customer (KYC) process to verify sellers on our platform. Sellers must upload their government-issued ID and verify their information, similar to opening a bank account. We reserve the right to request additional information or documentation to verify your identity and to suspend or terminate your account if we are unable to verify your information.

2. Ticket Listings
   2.1 Posting Tickets: Sellers may post music festival tickets for sale on our platform, including details such as the festival name, date, location, ticket type, and price. Sellers must provide accurate and complete information about the tickets they are selling.
   2.2 Ticket Confirmation: Sellers must post a picture of the email confirmation or the ticket itself. All ticket listings are subject to our approval process, and we reserve the right to reject or remove any listing at our discretion.
   2.3 Pricing and Fees: Sellers may set their own ticket prices. Rave Trade charges a \$10 transaction fee for both the seller and the buyer.
   2.4 Intellectual Property: By posting a ticket listing, you grant Rave Trade a non-exclusive, worldwide, royalty-free license to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content in connection with our Services.

3. Transactions and Payments
   3.1 Buyer and Seller Communication: Buyers and sellers can communicate within the listing page using a discussion-style format. All communication must be respectful and comply with our Community Guidelines.
   3.2 Payment Processing: Rave Trade does not directly handle payments. Buyers and sellers are connected via PayPal to complete the transaction. Buyers must pay using PayPal's Goods and Services option to ensure transaction protection.
   3.3 Disputes: In the event of a dispute, buyers and sellers must follow PayPal's dispute resolution process. Rave Trade is not responsible for resolving payment disputes between buyers and sellers.
   3.4 Escrow: In the future, Rave Trade may implement its own escrow system to protect payments. If and when this feature is available, additional terms and conditions will apply.

4. User Conduct
   4.1 Prohibited Activities: When using our Services, you agree not to:
      a. Violate any applicable laws, regulations, or third-party rights;
      b. Post false, inaccurate, misleading, defamatory, or libelous content;
      c. Engage in fraudulent, deceptive, or manipulative practices;
      d. Interfere with or disrupt the integrity or performance of our Services;
      e. Attempt to gain unauthorized access to our Services or other users' accounts;
      f. Use our Services for any unlawful or unauthorized purpose.
   4.2 Community Guidelines: You agree to comply with our Community Guidelines, which outline acceptable behavior on our platform. We reserve the right to remove any content or terminate any account that violates our Community Guidelines.

5. Feedback and Ratings
   5.1 Feedback: After a transaction is completed, buyers and sellers can rate each other and leave feedback on their experience. Feedback must be honest, accurate, and not defamatory or offensive.
   5.2 Ratings: Users can rate various aspects of the transaction, including ticket arrival, event information accuracy, and seller communication. These ratings contribute to a user's overall reputation on the platform.
   5.3 Disputes: If you believe that feedback or ratings you received are unfair or inaccurate, you may contact our customer support team for assistance. We reserve the right to remove any feedback or ratings that violate our policies.

6. Intellectual Property
   6.1 Ownership: Our Services and all content and materials included therein, such as text, graphics, logos, images, and software, are the property of Rave Trade or its licensors and are protected by intellectual property laws.
   6.2 License: Subject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, and revocable license to access and use our Services for your personal, non-commercial use.
   6.3 Trademarks: Rave Trade and all related logos, product and service names, designs, and slogans are trademarks of Rave Trade or its affiliates or licensors. You may not use such marks without our prior written permission.

7. Disclaimer of Warranties
   7.1 AS IS: Our Services are provided "as is" and "as available" without warranties of any kind, either express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, non-infringement, or course of performance.
   7.2 Content: We do not endorse or guarantee the accuracy, completeness, or reliability of any user-generated content on our platform. You acknowledge that any reliance on such content is at your own risk.
   7.3 Third-Party Services: Our Services may contain links to third-party websites or services that are not owned or controlled by Rave Trade. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party websites or services.

8. Limitation of Liability
   8.1 Indirect Damages: To the fullest extent permitted by law, Rave Trade shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to damages for lost profits, goodwill, use, data, or other intangible losses, arising out of or in connection with your use of our Services.
   8.2 Liability Cap: In no event shall Rave Trade's total liability to you for all claims arising out of or in connection with your use of our Services exceed the amount paid by you, if any, to Rave Trade during the six (6) months immediately preceding the date on which the claim arose.
   8.3 Basis of the Bargain: The limitations of liability set forth in this Section 8 are fundamental elements of the basis of the bargain between Rave Trade and you.

9. Indemnification
   You agree to indemnify, defend, and hold harmless Rave Trade, its affiliates, officers, directors, employees, agents, licensors, and suppliers from and against any claims, liabilities, damages, judgments, awards, losses, costs, expenses, or fees (including reasonable attorneys' fees) arising out of or in connection with your violation of these Terms or your use of our Services.

10. Termination
    10.1 By You: You may terminate your account at any time by contacting our customer support team.
    10.2 By Rave Trade: We may suspend or terminate your account or access to our Services at any time, for any reason, without prior notice or liability.
    10.3 Effect of Termination: Upon termination of your account, your right to access and use our Services will immediately cease. Termination of your account does not relieve you of any obligations arising or accruing prior to such termination.

11. Governing Law and Dispute Resolution
    11.1 Governing Law: These Terms shall be governed by and construed in accordance with the laws of the State of Florida, without regard to its conflict of law provisions.
    11.2 Arbitration: Any dispute, claim, or controversy arising out of or relating to these Terms or the breach, termination, enforcement, interpretation, or validity thereof, shall be resolved by binding arbitration in accordance with the rules of the American Arbitration Association.
    11.3 Venue: The arbitration shall be conducted in Miami, Florida, and judgment on the arbitration award may be entered in any court having jurisdiction thereof.
    11.4 Waiver of Class Actions: You agree that any arbitration or legal action shall be conducted only on an individual basis and not in a class, consolidated, or representative action.

12. Miscellaneous
    12.1 Entire Agreement: These Terms constitute the entire agreement between you and Rave Trade regarding your use of our Services and supersede all prior agreements and understandings, whether written or oral.
    12.2 Waiver: Our failure to enforce any right or provision of these Terms shall not be considered a waiver of such right or provision.
    12.3 Severability: If any provision of these Terms is held to be invalid or unenforceable, such provision shall be struck and the remaining provisions shall be enforced to the fullest extent permitted by law.
    12.4 Assignment: You may not assign or transfer these Terms, by operation of law or otherwise, without our prior written consent. We may assign these Terms at any time without notice or consent.
    12.5 Contact Information: If you have any questions about these Terms, please contact us at plur@ravetradeapp.com

By using our Services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Use.
""";
}
