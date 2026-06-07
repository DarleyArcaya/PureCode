import 'package:flutter/material.dart';
import 'api_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // This is for connect api with flutter or the app with Internet 
import 'package:url_launcher/url_launcher.dart'; // this is for launcher the url in web browser


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('PureCode'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF0F172A),
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
              Text("Settings",
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
                      title: Text('About PureCode', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),

                      content: Text("PureCode is a tool designed to optimize the workflow of developers and advanced users by simplifying system maintenance. With a single click, it allows you to debug workstations by deleting unnecessary temporary files and caches. Its most notable feature is the ability to manage and reduce 'System Data' files on macOS, freeing up storage space quickly and safely."
                      , style: TextStyle(fontSize: 20, color: Color(0xFF0F172A))),
                    
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
                            )
                          );
                        }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Something wents wront"),
                            backgroundColor: Colors.red,
                            )
                          );
                        }
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not connect to the server"),
                      backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
          
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("What is new and fixed", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              subtitle: Text("Check the changelog for more information", style: TextStyle(color: Colors.black)),

              onTap: () {
                Navigator.of(context).pop();

                
              },
            

            )
            


 
            
          ],
        ),
      ),
      body: Center(
        
        child: Column(

          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 130,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
              
                ),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    
                      // Cambia el cursor a una mano para indicar que es interactivo
            
                      InkWell( // This Widgets allows us to detect taps on the image, making it interactive and capable to delete MAC CACHES
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Your Mac System Data Caches have been cleaned!"),
                            backgroundColor: Colors.blue
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
                    'assets/cleanpc/mac.png', 
                    height: 100, 
                    width: 100, 
                    fit: BoxFit.contain
                      ),
                    ),
                  ),
                ),
                    
                    
                const SizedBox(width: 50), // Espacio entre las dos imágenes // Space between the two images

                 // Cambia el cursor a una mano para indicar que es interactivo
                  InkWell( // This Widgets allows us to detect taps on the image, making it interactive and capable to delete WINDOWS CACHES

                    onTap: () async {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Your Windows System Data Caches Have Been Cleaned!"),
                        backgroundColor: Colors.blue
                          )
                        );
                      },

                  child: MouseRegion(
                      cursor: SystemMouseCursors.click, // Cambia el cursor a una mano para indicar que es interactivo
                  
                  child: Container(
                    padding: const EdgeInsets.all(10), // Padding para darle margen interno // Padding for internal margin
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Importante para que el ripple se vea bien // Important for the ripple effect to look good
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 0)], // This boxShadow is used to create a shadow effect around
                  ),

                  child: Image.asset(
                  'assets/cleanpc/win.png', 
                  height: 100, 
                  width: 100, 
                  fit: BoxFit.contain
                           ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              
              ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 800,
                height: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE2E8F0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text('Copyright © 2026 by Darley Silot Arcaya'),
              Spacer(),
              ElevatedButton(
                onPressed: () async { 
                  
                  if (!gradleCaches && !androidCaches && !flutterCaches && !pipCaches) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one cache to clean.'),
                        backgroundColor: Colors.orange,
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