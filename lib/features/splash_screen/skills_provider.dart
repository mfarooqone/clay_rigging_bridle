// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SkillsNotifier extends StateNotifier<List<String>> {
//   SkillsNotifier() : super(['Flutter', 'React Native', 'Android']);

//   void addSkill(String skill) {
//     if (skill.isNotEmpty && !state.contains(skill)) {
//       state = [...state, skill];
//     }
//   }

//   void removeSkill(String skill) {
//     state = state.where((s) => s != skill).toList();
//   }
// }

// final skillsProvider = StateNotifierProvider<SkillsNotifier, List<String>>((
//   ref,
// ) {
//   return SkillsNotifier();
// });
