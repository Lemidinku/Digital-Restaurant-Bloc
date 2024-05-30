// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:restaurant/presentation/detail.dart'; // Adjust the import to match your file structure

// void main() {
//   group('FoodDetailPage Widget Tests', () {
//     const String title = 'Test Food';
//     const String imagePath = 'assets/tibs.jpg'; // This will be ignored in tests
//     const String rating = '4.5';
//     const String kind = 'Dessert';
//     const String type = 'Cake';
//     const String origin = 'Ethiopia';
//     const String price = '\$10';

//     testWidgets('displays food details correctly', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: FoodDetailPage(
//             title: title,
//             imagePath:
//                 imagePath, // Still need to provide this, but won't test it
//             rating: rating,
//             kind: kind,
//             type: type,
//             origin: origin,
//             price: price,
//           ),
//         ),
//       );

//       // Check if the title is displayed correctly
//       expect(find.text(title), findsOneWidget);

//       // Check if the kind, type, origin, and price are displayed correctly
//       expect(find.text('Kind: $kind'), findsOneWidget);
//       expect(find.text('Type: $type'), findsOneWidget);
//       expect(find.text('Origin: $origin'), findsOneWidget);
//       expect(find.text('Price: $price'), findsOneWidget);

//       // Check if the rating bar is displayed correctly
//       expect(find.byType(RatingBar), findsOneWidget);
//     });

//     testWidgets('rating bar updates rating correctly',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         const MaterialApp(
//           home: FoodDetailPage(
//             title: title,
//             imagePath:
//                 imagePath, // Still need to provide this, but won't test it
//             rating: rating,
//             kind: kind,
//             type: type,
//             origin: origin,
//             price: price,
//           ),
//         ),
//       );

//       // Find the RatingBar widget
//       final ratingBarFinder = find.byType(RatingBar);

//       // Ensure the RatingBar is found
//       expect(ratingBarFinder, findsOneWidget);

//       // Simulate updating the rating
//       final firstStar = find.byIcon(Icons.star).first;
//       await tester.tap(firstStar);
//       await tester.pump();

//       // Additional checks or logic to verify the rating update can be added here
//     });
//   });
// }
