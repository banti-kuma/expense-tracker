import '../../export.dart';

Widget imageFile(File file,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.file(
      file,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageMemory(Uint8List bytes,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    Image.memory(
      bytes,
      height: height,
      width: width,
      fit: fit,
    );

Widget imageNetwork(String url,
        {double? scale, double? width, double? height, BoxFit? fit}) =>
    FancyShimmerImage(
      imageUrl: url,
      height: height!,
      width: width!,
      boxFit: fit!,
    );

imageAssetProvider(name) => AssetImage(name);

imageNetworkProvider(name) => NetworkImage(name);

imageFileProvider(name) => FileImage(name);

Widget cachedImage(
  url, {
  double? height,
  double? width,
  BoxFit boxFit = BoxFit.contain,
}) {
  return FancyShimmerImage(
    width: width!,
    height: height!,
    boxFit: boxFit,
    imageUrl: url ?? "",
  );
}

