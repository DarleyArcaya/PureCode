
int optimizeDate() {
  final currentDateTime = DateTime.now(); // Get the current date and time
  return currentDateTime.difference(currentDateTime).inDays; // we get the difference between the current date and time in days
}


  

  

