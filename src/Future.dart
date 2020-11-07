Future<String> lookUpVersion() async => '1.0.0';

Future<void> checkVersion() async {
  var version = await lookUpVersion();
  print(version);
}

main() async{
  print(await lookUpVersion());
  print("=============");
  checkVersion();
}