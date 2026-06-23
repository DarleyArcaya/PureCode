int optimizeDate(DateTime? lastOptimization) {

  if (lastOptimization == null) {
    return 99;
  }
  final currentDateTime = DateTime.now(); // Get the current date and time
  return currentDateTime.difference(lastOptimization).inDays; // we get the difference between the current date and time in days
}


  

  

