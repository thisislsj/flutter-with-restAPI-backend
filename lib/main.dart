import 'package:flutter/material.dart';
import 'package:flutter_restapi/rest_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter with REST API Backend'),
      ),
      body: FutureBuilder(  
        future: ApiService.getEmployees(),
        builder: (context,snapshot){
          final employees=snapshot.data;
          if(snapshot.connectionState==ConnectionState.done){
          return ListView.separated( 
            separatorBuilder:(context,index){
              return Divider(  
                height:2,
                color:Colors.black,
              );
            },
            itemBuilder: (context,index){
              return ListTile(  
                title:Text(employees[index]['employee_name']),
                subtitle: Text('Age:${employees[index]['employee_age']}'),
              );
            },
            itemCount: employees.length,
          );
        }
        return Center(child: CircularProgressIndicator(),);

        },
        

      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: (){
          Navigator.push(  
            context,
            MaterialPageRoute(  
              builder: (context)=>AddNewEmployeePage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      
    );
  }
}

class AddNewEmployeePage extends StatefulWidget{
  AddNewEmployeePage({Key key}): super(key:key);

  _AddNewEmployeePageState createState() => _AddNewEmployeePageState();

}

class _AddNewEmployeePageState extends State<AddNewEmployeePage>{
  final _employeeNameController=TextEditingController();
  final _employeeAge=TextEditingController();

  @override  
  Widget build(BuildContext context){
    return Scaffold(  
      appBar: AppBar(  
        title: Text('New Employee'),
      ),
      body:Center(  
        child: Padding(  
          padding: EdgeInsets.all(10),
          child: Column(  
            children: <Widget>[  
              TextField(  
                controller: _employeeNameController,
                decoration: InputDecoration(hintText:'Employee Name'),
              

              ),
              TextField(  
                controller: _employeeAge,
                decoration: InputDecoration(hintText:'Employee Name'),
                keyboardType: TextInputType.number,

              ),
              RaisedButton(  
                child: Text(  
                  'SAVE',
                  style: TextStyle(  
                    color: Colors.white,
                  ),
                ),
                color: Colors.purple,
                onPressed: () {
                  final body={
                    "name": _employeeNameController.text,
                    "age": _employeeAge.text,

                  };
                  ApiService.addEmployee(body).then((success) {
                    if(success){
                      showDialog(
                        builder:(context)=>AlertDialog(  
                          title:Text('Employee has been added!!!'),
                          actions:<Widget>[ 
                            FlatButton(  
                              onPressed:(){
                                Navigator.pop(context);
                                _employeeNameController.text='';
                                _employeeAge.text='';
                              },
                              child:Text('OK'),
                            )
                          ],
                        ),
                        context:context,
                      );
                      return;
                    }else{
                      showDialog( 
                        builder:(context)=>AlertDialog(  
                          title: Text('Error Adding Employee!!!'),
                          actions:<Widget>[
                            FlatButton( 
                              onPressed:(){
                                Navigator.pop(context);
                              },
                              child:Text('OK'),
                            )
                          ],
                        ),
                        context:context,
                      );
                      return;
                    }
                  });
                  
                },

              )
            ],
          ),
        ),
      ),
    );
  }
}
