import 'dart:collection';
import 'package:learning/login.dart';
import 'package:learning/main.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: ForthRoute(),
  ));
}

class whateverer {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center( 
          
      ),
      );
  }
}

 bool visibility = true;

class ForthRoute extends StatelessWidget {
  const ForthRoute({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container( 
        color: Colors.black,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
             ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.man_outlined,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
          },
        ),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.map,
              color: Colors.white,
              ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const ThirdRoute()),
            );
          }
          ),
          
        ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.settings,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
        
       
        ],
        )
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: Border(bottom: BorderSide.none),
        backgroundColor: Colors.black,
        actions: [
        TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0);
        return null;
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    "  ACCOUNT                ",
    style: new TextStyle(
    
      fontSize: 42.0,
)
  ),
    ),
        ],
      ),
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        
       
        ]
      ),
    );
  }
}
class FifthRoute extends StatelessWidget {
  const FifthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container( 
        color: Colors.black,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
             ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.man_outlined,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
          },
        ),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.map,
              color: Colors.white,
              ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const ThirdRoute()),
            );
          }
          ),
          
        ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.settings,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
        
       
        ],
        )
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: Border(bottom: BorderSide.none),
        backgroundColor: Colors.black,
        actions: [
        TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0);
        return null; 
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    " VISIBILITY                ",
    style: new TextStyle(
    
      fontSize: 41.0,
)
  ),
    ),
        ],
      ),
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null;
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    "     VISIBLE TO:     ",
    style: new TextStyle(
      fontSize: 25.0,
)
  ),
    ),
          TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null; 
      },
    ),
  ),
  onPressed: () {visibility = true; },
  child: new Text(
    "ALL                         ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    ),
     TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null;
      },
    ),
  ),
  onPressed: () {visibility = false; },
  child: new Text(
    "    NOONE                        ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    )
        ]
      ),
    );
  }
}
class SixthRoute extends StatelessWidget {
  
  const SixthRoute({super.key});

   Future<void> _askNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isDenied) {
      // The user denied permission
      print('Permission to send notifications is denied.');
    } else if (status.isGranted) {
      // Permission granted
      print('Permission to send notifications is granted.');
    } else if (status.isPermanentlyDenied) {
      // The user opted to never ask for permission again
      print('Permission to send notifications is permanently denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container( 
        color: Colors.black,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
             ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.man_outlined,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
          },
        ),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.map,
              color: Colors.white,
              ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder:  (context) => const ThirdRoute()),
            );
          }
          ),
          
        ElevatedButton(
         style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0)
            ),
          child: Icon(
              size: 40.0,
              Icons.settings,
              color: Colors.white,
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
        
       
        ],
        )
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: Border(bottom: BorderSide.none),
        backgroundColor: Colors.black,
        actions: [
        TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0);
        return null; 
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    " NOTFICATIONS       ",
    style: new TextStyle(
    
      fontSize: 42.0,
)
  ),
    ),
        ],
      ),
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null; 
      },
    ),
  ),
  onPressed: () {
    _askNotificationPermission(); 
    final snackBar = SnackBar(
                content: Text('asking for permision'),
                duration: Duration(seconds: 2),
              );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
  child: new Text(
    "       ON                     ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    ),
     TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0.08);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0.12);
        return null; 
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    "   OFF                ",
    style: new TextStyle(
      fontSize: 20.0,
)
  ),
    ),
        ]
      ),
    );
  }
}
