class ApiUrls {
  static const String baseUrl = "https://cheers.coach/nobese/apis/";
  static const String uploadImageUrl = "https://cheers.coach/nobese/uploads/";
  static const String assetsBaseUrl =
      "https://storage.googleapis.com/3rdeye/nobese/";

  ///

  static const String assetsPlanImagesBaseUrl = "${assetsBaseUrl}planImages/";

  static const String questionImages = "https://cheers.coach/nobese/uploads/";

  ///
  static const String assetsImagesBaseUrl = "${assetsBaseUrl}images/";
  static const String sleepImagesBaseUrl = "${assetsImagesBaseUrl}Sleep/";

  static const String imageUrl =
      "https://eminentphysician.com/testing/meditation/admin/upload/";

  /* -------------------------------------------------------------------------- */
  /*                                   videos                                   */
  /* -------------------------------------------------------------------------- */

  static const String assetsAudioBaseUrl = "${assetsBaseUrl}Audio/";
  static const String assetsVideoBaseUrl = "${assetsBaseUrl}videos/";
  static const String sleepVideoBaseUrl = "${assetsVideoBaseUrl}Sleep/";
  static const String mindVideoBaseUrl =
      "https://storage.googleapis.com/3rdeye/nobese/videos/Mind/";
  static const String exerciseVideoBaseUrl =
      "https://storage.googleapis.com/3rdeye/nobese/videos/Exercise/";

  ///
  /* -------------------------------------------------------------------------- */
  /*                                 images path                                */
  /* -------------------------------------------------------------------------  */
  static const String dietImages = "${assetsImagesBaseUrl}Diet/";
  static const String exerciseImages = "${assetsImagesBaseUrl}Exercise/";
  static const String mindImages = "${assetsImagesBaseUrl}Mind/";
  static const String cbtImages = "${assetsImagesBaseUrl}cbt/";

  static const String sleepImages = "${assetsImagesBaseUrl}Sleep/";
  // static const String cbtImages = "${assetsImagesBaseUrl}CBT/";
  // static const String exerciseImages = "${assetsImagesBaseUrl}Exercise/";
  // static const String mindImages = "${assetsImagesBaseUrl}Mind/";
  // static const String todoImages = "${assetsImagesBaseUrl}todos/";

  /* -------------------------------------------------------------------------- */
  /*                              plan images path                              */
  /* -------------------------------------------------------------------------- */

  ///
  static const String dietPlansBaseUrl = "${assetsPlanImagesBaseUrl}dietPlans/";

  static const String exercisePlansBaseUrl =
      "${assetsPlanImagesBaseUrl}exercisePlan/";

  static const String mindPlanImages = "${assetsPlanImagesBaseUrl}MindPlan/";

  ///

  ///
  ///
  ///
  static const String uploadUrl = "https://cheers.coach/api/uploads/";

  /* -------------------------------------------------------------------------- */
  /*                               authentication                               */
  /* -------------------------------------------------------------------------- */

  static const String getUserData = "authentication/user_details.php";
  static const String signUp = "authentication/register.php";
  static const String login = "authentication/login.php";
  static const String forget = "authentication/forget_password.php";
  static const String trigerDiet = "authentication/trigger_diet.php";
  static const String updateWeight = "authentication/update_weight.php";
  static const String deleteUser = "authentication/delete_user_update.php";

  /* --------------------------------------------------------------------------  */
  /*                             questionnarie                                   */
  /* --------------------------------------------------------------------------  */

  static const String ansQuestion = "question/answer.php";
  static const String getQuestion = "question/get_type_question.php";
  static const String userAnswer = "question/get_user_answer.php";

  /* --------------------------------------------------------------------------  */
  /*                                      cbt                                    */
  /* --------------------------------------------------------------------------  */

  static const String getCbtStartQuestion =
      "cbt_record/cbt_record_question.php";
  static const String postCbtStartAnswer = "cbt_record/cbt_record.php";
  static const String getCbt = "cbt/get_cbt.php";
  static const String getSleepCBT = "cbt/get_sleep_cbt.php";
  static const String postCbt = "cbt/add_cbt_answer.php";
  static const String cbtSum = "cbt_record/cbt_sum.php";

  /* -------------------------------------------------------------------------- */
  /*                                   scanner                                  */
  /* -------------------------------------------------------------------------- */

  static const String scanFood =
      'https://world.openfoodfacts.org/api/v0/product/';
  static const String addScanner = "scanner/addScanner.php";
  static const String fetchScanner = "scanner/fetchScanner.php";

  /* --------------------------------------------------------------------------  */
  /*                                       Diet                                  */
  /* --------------------------------------------------------------------------  */

  static const String getCuisinePlan = "plan/get_plan.php";
  static const String postActivePlan = "plan/active_plan.php";
  static const String managePlan = "plan/manage_plan.php";

  static const String getTypeQuestion = "question/get_type_question.php";
  static const String postAnswer = "question/answer.php";
  static const String getUserPlan = "plan/user_plan.php";
  static const String getPlanDetails = "plan/plan_details.php";
  static const String getDayDiet = "diet/get_day_diet.php";
  static const String getTodayDiet = "diet/get_today_diet.php";
  static const String allFood = "diet/all_food.php";
  static const String foodDetails = "diet/food_details.php";
  static const String customFoodDetails = "diet/get_customrecipe_details.php";
  static const String getReplaceFoodList = "diet/replacefood_list.php";
  static const String getReplaceFood = "diet/replace_food.php";
  static const String getCustomdietplan = "diet/get_customdietplan.php";

  /* -------------------------------------------------------------------------- */
  /*                                custom diet                                 */
  /* -------------------------------------------------------------------------- */

  static const String addCustomDiet = "diet/add_customdietplan.php";
  static const String addCustomRecipe = "diet/add_customrecipe.php";
  static const String getRecipeInfo = "diet/get_recipe_info.php";
  static const String getCustomRecipe = "diet/get_customrecipe.php";
  static const String activePlan = "plan/active_plan.php";

  /* -------------------------------------------------------------------------- */
  /*                                 checklist                                  */
  /* -------------------------------------------------------------------------- */

  static const String checkList = "authentication/checklist_add.php";

  /* -------------------------------------------------------------------------- */
  /*                                   mind                                     */
  /* -------------------------------------------------------------------------- */

  static const String addMindPlan = "mind/addMindPlan.php";
  static const String planDetail = "plan/plan_details.php";
  static const String getMindPlan = "mind/getmindplan.php";
  static const String mindDetailPlan = "mind/mindDetails.php";
  static const String addMindHistory = "mind/addMindHistory.php";

  /* -------------------------------------------------------------------------- */
  /*                                   sleep                                    */
  /* -------------------------------------------------------------------------- */

  static const String addSleep = "sleep/add_sleep.php";
  static const String getLastSleep = "sleep/get_last_sleep.php";
  static const String getSleepStory = "sleep/fetch_sleep.php";
  static const String selectCollection = "relaxing/select_collection.php";
  static const String relaxingSound = "relaxing/relexing_sound.php";

  /* -------------------------------------------------------------------------- */
  /*                                  exervise                                   */
  /* -------------------------------------------------------------------------- */
  static const String getExercise = "exercise/get_exercise.php";
  // static const String getAllExercise = "exercise/get_all_exercise.php";
  static const String getAllWorkout = "exercise/get_all_workout.php";
  static const String workoutCategoryGet = "exercise/workoutcategory_get.php";
  static const String exerciseDetail = "exercise/exercise_details.php";
  static const String addCustomExercise = "exercise/customexercise_add.php";
  static const String getCustomExercise = "exercise/customexercise_get.php";
  static const String deleteCustomExercise =
      "exercise/customexercise_delete.php";
  static const String getUserExerciseHistory =
      "exercise/getUserExerciseHistory.php";
  static const String addExerciseHistory = "exercise/add_exercise_history.php";

  /* -------------------------------------------------------------------------- */
  /*                                   fasting                                   */
  /* -------------------------------------------------------------------------- */

  static const String userFasting = "fasting/userfasting.php";
  static const String getDataFasting = "fasting/fetch_date_userfasting.php";
  static const String getFastingHistory = "fasting/select_userfasting.php";
  static const String fastingComplete = "fasting/check_fastingtime.php";
  static const String endFasting = "fasting/update_userfasting_endtimetime.php";

  /* -------------------------------------------------------------------------- */
  /*                                    medicine                                */
  /* -------------------------------------------------------------------------- */

  static const String addMedicine = "medicine/add_medicine.php";
  static const String getMedicine = "medicine/get_medicine.php";
  static const String rescheduleMedicine = "medicine/reschedule_medicine.php";
  static const String selectMedicine = "medicine/select_medicine.php";
  static const String takeMedicine = "medicine/take_medicine.php";
  static const String deleteMedicine = "medicine/delete_medicine.php";
  static const String updateMedicine = "medicine/update_medicine.php";
  static const String getSleepData = "sleep/fetch_sleep_data.php";

  /* -------------------------------------------------------------------------- */
  /*                                   diary                                    */
  /* -------------------------------------------------------------------------- */

  static const String addDiary = "diary/add_diary.php";
  static const String getDiary = "diary/fetch_diary.php";
  static const String countHistoryConsumption =
      "diary/countHistoryConsumption.php";
  /* -------------------------------------------------------------------------- */
  /*                                   Profile                                  */
  /* -------------------------------------------------------------------------- */

  static const String addPersonalInformation = "user/personal_information.php";
  static const String changePassword = "user/update_password.php";
  static const String addFile = "uploads/addFile.php";
  static const String getFaq = "faq/select_faq.php";
  static const String addReview = "review/review.php";

  /* -------------------------------------------------------------------------- */
  /*                                   Water                                    */
  /* -------------------------------------------------------------------------- */
  static const String addWater = "water/water.php";
  static const String getSelectWater = "water/select_water.php";

  /* -------------------------------------------------------------------------- */
  /*                                   Grocery                                  */
  /* -------------------------------------------------------------------------- */
  static const String getGrocery = "grocery/fetch_grocery.php";
  static const String addUserGrocery = "grocery/add_grocery.php";
  static const String deleteGrocery = "grocery/deleteGrocery.php";

  /* -------------------------------------------------------------------------- */
  /*                                  trigger                                   */
  /* -------------------------------------------------------------------------- */

  static const String triggerDay = "authentication/trigger_day.php";

  /* -------------------------------------------------------------------------- */
  /*                                  Selfie                                    */
  /* -------------------------------------------------------------------------- */
  static const String addSelfie = "selfie/add_selfie.php";
  static const String fetchSelfie = "selfie/fetch_selfie.php";
  static const String fetchSelfieJourney = "selfie/fetch_journey.php";

  /* -------------------------------------------------------------------------- */
  /*                                custom Package                              */
  /* -------------------------------------------------------------------------- */

  static const String customPackage2 = "package/customPackage2.php";
  static const String purchasepackage = "package/purchasepackage.php";

  /* -------------------------------------------------------------------------- */
  /*                                   todos                                    */
  /* -------------------------------------------------------------------------- */

  static const String getTodos = "todo/get_todo.php";
  static const String addTodo = "todo/add_taskdiary.php";

  /* -------------------------------------------------------------------------- */
  /*                                   Progress                                 */
  /* -------------------------------------------------------------------------- */

  static const String getprogrss = "progress/progress.php";

  /* -------------------------------------------------------------------------- */
  /*                                  cheat day                                 */
  /* -------------------------------------------------------------------------- */

  static const String addCheatFood = "cheatfood/cheatfood_add.php";
  static const String getCheatFood = "cheatfood/cheatfood_get.php";
  static const String checkCheatFood = "cheatfood/check_cheatfood.php";

  /* -------------------------------------------------------------------------- */
  /*                                  community                                 */
  /* -------------------------------------------------------------------------- */

  static const String getCommunityDetail = "community_details/get_detail.php";
  static const String getUserProfile = "community_profile/get_profile.php";

  static const String addDetail = "community_details/add_detail.php";
  static const String editUserProfile = "community_profile/profile.php";
  static const String creatPost = "posts/create_post.php";

  static const String getUserPost = "community_profile/get_profile_post.php";

  static const String forYouPost = "posts/posts.php";
  static const String communityLike = "posts/post_like.php";
  static const String createGroups = "groups/group.php";
  static const String getGroups = "groups/get_group.php";
  static const String joinGroups = "groups/join_group.php";
  static const String getPeople = "followers/follower.php";
  static const String getCommunityGroups = "groups/group.php";
  static const String creatGroupPost = "groups/group_post.php";

  /* -------------------------------------------------------------------------- */
  /*                                  challenges                                 */
  /* -------------------------------------------------------------------------- */

  static const String challengeCategory = "challenge/get_challengecategory.php";
  static const String getChallenge = "challenge/get_challenge.php";
  static const String challengeHistory = "challengehitory/challengehistory.php";
  static const String addChallenge = "challenge/add_challenge.php";
  static const String challengeRecord = "challenge/get_challengerecord.php";

  /* -------------------------------------------------------------------------- */
  /*                                  favorite                                   */
  /* -------------------------------------------------------------------------- */

  static const String addFavorite = "favourite/addfavourite.php";
  static const String getFavorite = "favourite/getfavourite.php";
  static const String deleteFavorite = "favourite/deletefavourite.php";

  /* -------------------------------------------------------------------------- */
  /*                                 category sounds                            */
  /* -------------------------------------------------------------------------- */

  static const String guitarSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Guitar Sounds/";
  static const String relaxingSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Meditation/Relaxing/";
  static const String birdsSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Birds Sounds/";
  static const String healingSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/inspirational music/Healing/";
  static const String pianoSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Piano Music/";
  static const String natureSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Nature Sounds/";
  static const String focusSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/inspirational music/Focus and Productivity/";
  static const String energySounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/inspirational music/Energy and Positivity/";
  static const String melodiesSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Meditation/Soulful Melodies/";
  static const String tranquilySounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Meditation/Tranquility Tracks/";
  static const String echoesSounds =
      "https://storage.googleapis.com/3rdeye/meditation/Audio/Meditation/Mindful Echoes/";

  /* -------------------------------------------------------------------------- */
  /*                                   comments                                */
  /* -------------------------------------------------------------------------- */

  static const String addComment = "posts/comments.php";
  static const String getComment = "posts/comments.php";
  static const String deleteComment = "posts/comments.php";
  static const String updateComment = "posts/comments.php";
}
