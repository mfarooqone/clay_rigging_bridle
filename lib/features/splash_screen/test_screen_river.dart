// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'skills_provider.dart';

// class TestScreenRef extends ConsumerStatefulWidget {
//   const TestScreenRef({super.key});

//   @override
//   ConsumerState<TestScreenRef> createState() => _TestScreenRefState();
// }

// class _TestScreenRefState extends ConsumerState<TestScreenRef> {
//   final TextEditingController skillController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final skills = ref.watch(skillsProvider);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             /// Header
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.blue[800],
//                 borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(10),
//                   topLeft: Radius.circular(10),
//                 ),
//               ),
//               child: const Center(
//                 child: Text(
//                   "Technical Skills",
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//               ),
//             ),

//             /// Skills List
//             ...skills.map(
//               (skill) => Container(
//                 margin: const EdgeInsets.only(top: 2),
//                 decoration: BoxDecoration(color: Colors.blueGrey.shade200),
//                 child: ListTile(
//                   leading: IconButton(
//                     icon: const Icon(Icons.close, color: Colors.red),
//                     onPressed:
//                         () => ref
//                             .read(skillsProvider.notifier)
//                             .removeSkill(skill),
//                   ),
//                   title: Text(skill),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 ),
//               ),
//             ),

//             /// Input & Add Button
//             Container(
//               margin: const EdgeInsets.only(top: 8),
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(5),
//                 boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: skillController,
//                       decoration: const InputDecoration(
//                         hintText: "Enter your skill",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       ref
//                           .read(skillsProvider.notifier)
//                           .addSkill(skillController.text.trim());
//                       skillController.clear();
//                     },
//                     child: const Text("Add"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
