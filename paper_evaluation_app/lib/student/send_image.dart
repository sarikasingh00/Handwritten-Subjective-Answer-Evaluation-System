import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class SendImage {
  Future<String> getExtractedText(File imageFile) async {
    String text = "";
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.43.105:5000/");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('img', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    var body = await http.Response.fromStream(response);
    print(jsonDecode(body.body));
    
    // print("body ${body.body["text"]}");
    text = jsonDecode(body.body)["text"];
    print("in send image.dart 2 $text");
    
    return text;
  }
}
