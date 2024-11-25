import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiTranscribe{

static const String endpoint = "http://192.168.15.69:8080";

static Future<void>  uploadPhoto(File image) async {
  Uint8List imageBytes = File(image.path).readAsBytesSync();

  http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse("$endpoint/transcribe"));

  http.MultipartFile imageHttp = http.MultipartFile.fromBytes(
    'file', imageBytes, filename: 'teste', contentType: MediaType.parse(lookupMimeType(image.path) ?? 'application/octet-stream'));

  request.files.add(imageHttp);

  var response = await request.send();

  if (response.statusCode == 200) {
    Uint8List bytes = await response.stream.toBytes();
    final file = File('${Directory.systemTemp.path}/tmpaudio');
    await file.writeAsBytes(bytes);
  } else {
    throw Exception('Erro ao fazer upload da imagem: ${response.statusCode}');
  }
}

}