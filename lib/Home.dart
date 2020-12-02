import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controlerCep = TextEditingController();

   String _Resultado= "";

  //Comunicação síncrona(sync) e assinacrona (async)

  _recuperarCEP() async {
    String cep = _controlerCep.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";

    http.Response response;
    response = await http.get(url);

     // json.decode(response.body); //decodificar json
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];


    //print("resposta: " + response.statusCode.toString());
    print("resposta: " + response.body);

    print(
      "Resposta Logradouro:  ${logradouro} Bairro: ${bairro} Localidade: ${localidade} - ${uf}"
    );

    setState(() {
      if(complemento == true) {
        _Resultado = " ${logradouro} ,${complemento}, ${bairro}, ${localidade} - ${uf}";
      }else{
        _Resultado = " ${logradouro}, ${bairro}, ${localidade} - ${uf}";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
      padding: EdgeInsets.all(40),
      child: Column(
        children: <Widget>[

          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
             labelText: "Digite o cep: (ex: 05412200)"
            ),
            style: TextStyle(
              fontSize: 20,
            ),
              controller: _controlerCep,
            maxLength:8,

          ),



      Padding(
        padding: EdgeInsets.all(15),
        child:
        RaisedButton(
          onPressed: _recuperarCEP,
          child: Text( "Clique aqui",
          style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20
          ),
          ),
          color: Colors.yellow,
        ),
      ),

          Text(_Resultado)
        ],
      ) ,
    ),
    );
  }
}
