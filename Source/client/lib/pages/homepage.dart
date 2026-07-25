import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // This is for connect api with flutter or the app with Internet 
import 'package:url_launcher/url_launcher.dart'; // this is for launcher the url in web browser
import 'optimize_pc.dart';
import 'package:purecode/helpers/theme_controller.dart';
import 'install_github_package.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final int _index = 0; // this variable goes in NavigationRail, this variable cannot goes inside the Widget build method because it's a state variable and cannot be changed

  // State variables to track which caches are selected for cleaning
  bool gradleCaches = false;
  bool androidCaches = false;
  bool flutterCaches = false;
  bool pipCaches = false;
  bool macCaches = false;
  bool winCaches = false;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF8FAFC), this is not needed, the file theme_controller is managing this.
      appBar: AppBar(
        title: const Text('PureCode'),
        automaticallyImplyLeading: false, // false to hide the leading icon / No muestra el icono para virar en las paginas
        
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          
          
        ),
        
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: IconThemeData(color: Colors.white), // this is for give a color to icon themes in appbar

      ),
    
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0F172A)
              ),
              child: 
              Text(
                "Settings",
                
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              )
              ),
              
              
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop(); // This is for close the drawer once users click on it 

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('About PureCode', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                      content: Text("PureCode is a tool designed to optimize the workflow of developers and advanced users by simplifying system maintenance. With a single click, it allows you to debug workstations by deleting unnecessary temporary files and caches. Its most notable feature is the ability to manage and reduce 'System Data' files on macOS, freeing up storage space quickly and safely. \n\n\n\n\n\n\n Copyright © 2026 by Darley Silot Arcaya"
                      , style: TextStyle(fontSize: 20, )),
                    
                    );
                  }
                );
              }, 
            ),
            ListTile(
              leading: Icon(Icons.update), 
              title: Text("Check for Updates", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Check for updates and download them from GitHub"),
              onTap: () async {
                Navigator.of(context).pop(); // This is for close the drawer once users click on it 
                  try{
                    final update = await http.get(Uri.parse('http://127.0.0.1:8000/check_updates'));

                    // FRENO DE MANO: Si el usuario se salió de la pantalla mientras esperábamos al servidor,
                    // frenamos aquí para evitar que la app crashee al intentar dibujar en una pantalla muerta.
                    if (!context.mounted) return;
                    

                      if (update.statusCode == 200){
                        final data = json.decode(update.body); // we are using the library convert to use this code line and convert text to JSON
                        
                        if (data['has_update'] == true){
                          _showUpdateDialog(context, data['latest_version']);
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No updates avaliable"),
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.floating,
                            )
                          );
                        }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error connecting to the server"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            )
                          );
                        }
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not connect to the server"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
          
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("What is new and fixed", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Check the changelog for more information"),

              onTap: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Center(
                    child: ListView(
                      
                      children: [
                        Text("Version: 0.9.0", style: TextStyle(
                         fontSize: 30, fontWeight: FontWeight.bold), 
                         textAlign: TextAlign.center
                         ),
                        // we will use \n for move down the line // usaremos \n para moverse a la siguiente línea (o sea para abajo)//
                        Text("What's New? \n", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text("Here will be writteng news things")
                      ],
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(1)
                    ),
                  ),
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 200,
                  isScrollControlled: true,

                );
              },
            ),
          
          ValueListenableBuilder(
            valueListenable: isDarkMode,
            builder: (context, isDark, child) {
              return ListTile(
                leading: Icon(Icons.light_mode),
                title: Text("Light Mode / Dark Mode", style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Switch(
                  value: isDark,
                  onChanged: (value) {
                    isDarkMode.value = value; 
                    SharedPreferences.getInstance().then((prefs) { // Esto es para guardar el estado del tema en SharedPreference
                      prefs.setBool('isDarkMode', value);
                        }
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),


      body: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xFF0F172A),
            selectedIndex: _index,
            onDestinationSelected: (int index) {
              if (index == 0) {
                // This is home
              }
              if (index == 1) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => OptimizeWindow())
                  );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder:(context) => InstallGitPackaged())
                  );

              }
            
            },
            indicatorColor: Colors.white,
            unselectedIconTheme: IconThemeData(color: Colors.white), // This is for give a color to unselected Icons
            selectedIconTheme: IconThemeData(color: Colors.blue), // this is for give a color to selected Icons


            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bolt),
                label: Text('Optimize Pc', style: TextStyle(fontSize: 16, color: Colors.white))
              ),
              NavigationRailDestination(
                icon: Icon(Icons.download_rounded),
                label: Text("Install GitHub" "\n" "Packaged", style: TextStyle(fontSize: 16, color: Colors.white))
              )
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),

        Expanded(
        child: Column(

          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 130,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  // color: const Color.fromARGB(255, 233, 233, 233), we wont use this because it is hardCoded
                  color: Theme.of(context).cardColor, // we use this because .cardColor will use the color that flutter asing to our theme
                                                      // usamos esto porque .cardColor sera el color que flutter asignara automaticamente a las tarjetas/contenedores segun si estas en modo oscuro o claro

              
                ),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    
                      // Cambia el cursor a una mano para indicar que es interactivo
            
                      InkWell( // This Widgets allows us to detect taps on the image, making it interactive and capable to delete MAC CACHES
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Welcome to PureCode, your optimization developer app"),
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.floating,
                            )
                          );
                        },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click, // Cambia el cursor a una mano para indicar que es interactivo
                    
                    child: Container(
                      padding: const EdgeInsets.all(10), // Padding para darle margen interno // Padding for internal margin
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Importante para que el ripple se vea bien // Important for the ripple effect to look good
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 0)], // This boxShadow is used for the ripple effect // This boxShadow
                    ),

                    child: Image.asset(
                    'assets/cleanpc/storage.png', 
                    height: 100, 
                    width: 100, 
                    fit: BoxFit.contain
                      ),


                    ),
                    
                  ),
                ),
                    
                    
                const SizedBox(width: 10), // Espacio entre las dos imágenes // Space between the two images
                  
                  Expanded(
        
                    child: Text('Welcome', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF2196F3))),
                  
                  
                  ),

                
                  ],
                  
                ),
              ),

            ),
            

            Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                //width: 800,
                //height: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  //color: const Color.fromARGB(255, 233, 233, 233),
                  color: Theme.of(context).cardColor,
                  ),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      SizedBox(height: 20),
                      

                      CheckboxListTile( 
                        // This widget provides a checkbox with a title and subtitle, making it ideal for our cache cleaning options
                        title: Text('Gradle Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Title of the checkbox
                        subtitle: Text('Removes .gradle build artifacts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)), // Subtitle providing more information about what this option does
                        value: gradleCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            gradleCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),



                      CheckboxListTile(
                        title: Text('Android Studio Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Android Studio Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
                        value: androidCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            androidCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Flutter Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Flutter Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
                        value: flutterCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            flutterCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Pip Python Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Pip Python Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
                        value: pipCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            pipCaches = value ?? false;
                          });
                        }
                      )

                      ],
                  ),
                  ),
                ),
            )
            
          ],
        ),
        
      ),
        ]
      ),
      

      bottomNavigationBar: BottomAppBar(
        //color: const Color(0xFFE2E8F0), we dont need this, it is managed by theme_controller
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              
              Spacer(), // This is for spacing between the buttons

              ElevatedButton(
                onPressed: () async { 
                  
                  if (!gradleCaches && !androidCaches && !flutterCaches && !pipCaches) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one cache to clean.'),
                        backgroundColor: Colors.orange,
                        behavior: SnackBarBehavior.floating,
                      )
                    );
                    return;
                  }

                  bool success = true;
                  
                  if (gradleCaches) {
                    await ApiServices.removeGradleCaches();
                    if (!gradleCaches) success = false;
                  }
                  if (androidCaches) {
                    await ApiServices.removeAndroidCaches();
                    if (!androidCaches) success = false;
                  }
                  if (flutterCaches) {
                    await ApiServices.removeFlutterCaches();
                    if (!flutterCaches) success = false;
                  }
                  if (pipCaches) {
                    await ApiServices.removePipPythonCaches();
                    if (!pipCaches) success = false;
                  }

                  // Avoid the "async gaps" error by ensuring the screen remains active
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                      ? 'Selected caches cleaned successfully!'
                      : 'An error ocurred while cleaning caches. Please try again.'),
                      backgroundColor: success ? Colors.blue : Colors.red,
                      behavior: SnackBarBehavior.floating,
                    )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white
                ), 
                child: const Text('Clean'),
              )
            ],
          )
        ),
        
      )
      );
      
      
    
  }

  void _showUpdateDialog(BuildContext context, String latestVersion) { // This is for check updates
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.system_update, color: Colors.blue),
              SizedBox(width: 10),
              Text('New update available'),
            ],

          ),
          content: Text(
            "A new version of PureCode (v$latestVersion) is available. "
            "Please Update to access the latest optimization features.",
            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Later', style: TextStyle(color: Colors.red))
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Here we used flutter pub add url_launcher
                // then, we imported "import 'package:url_launcher/url_launcher.dart';"
                // once done it, we can use the following code 

                final url = Uri.parse("https://github.com/DarleyArcaya/PureCode/releases");
                launchUrl(url); // This is for open the url in browser. 


              },
              child: const Text('Update Now')
              
    
              )
          ],
        );
        }
      );


  }
}