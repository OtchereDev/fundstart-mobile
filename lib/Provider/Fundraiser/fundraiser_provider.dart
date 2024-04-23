import 'dart:io';

import 'package:crowdfunding/Components/custom_toast.dart';
import 'package:crowdfunding/Components/loading_item.dart';
import 'package:crowdfunding/Model/Requests/fundraiser_request.dart';
import 'package:crowdfunding/Model/Response/catefory_model.dart';
import 'package:crowdfunding/Model/Response/fundraiser_model.dart';
import 'package:crowdfunding/Model/Response/investors_response.dart';
import 'package:crowdfunding/Services/Remote/Fundraiser/fundraiser_service.dart';
import 'package:crowdfunding/Utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';

class FundRaiserProvider extends ChangeNotifier {
  final fundraiserServices = FundraiserService();
  bool _loadPage = false;
  bool get isLoading => _loadPage;

  FundRaiserModel? _fundRaiserModel = FundRaiserModel();
  FundRaiserModel? get fundRaiserModel => _fundRaiserModel;

  InvestorsResponse? _investorsResponse = InvestorsResponse();
  InvestorsResponse? get investorsResponse => _investorsResponse;

  Fundraiser _fundraiser = Fundraiser();
  Fundraiser get fundraiser => _fundraiser;

  CategoryModel? _categoryModel;
  CategoryModel? get categoryModel => _categoryModel;
  DateTime _dateTime = DateTime.now();
  DateTime get dateTime => _dateTime;

  String? _catID;
  String? get catID => _catID;

  setDate(DateTime date) {
    _dateTime = date;
    notifyListeners();
  }

  setCategoryID(String id) {
    _catID = id;
    notifyListeners();
  }

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  String _imageString = "";
  String get imageString => _imageString;

  setLoadingPage(bool value) {
    _loadPage = value;
    notifyListeners();
  }

  clearImage() {
    _imageFile = null;
  }

  void selectProfileImages() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 60,
    );
    _cropImage(image?.path);
  }

  Future<void> _cropImage(filePath) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
      // aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
    );

    if (croppedFile != null) {
      _setImage(croppedFile);
    }
  }

  _setImage(File value) {
    _imageFile = XFile(value.path);
    Utils.convertImageToBase64(_imageFile!.path).then((value) {
      _imageString = ("data:image/jpeg;base64,$value");
      notifyListeners();
    });
    notifyListeners();
  }

  setFundRaiser(Fundraiser fundraiser) {
    _fundraiser = fundraiser;
    notifyListeners();
  }

  getFundraisers(context) async {
    setLoadingPage(true);
    await fundraiserServices.getAllFundraiser(context).then((value) {
      setLoadingPage(false);
      if (value['status'] == true) {
        _fundRaiserModel = FundRaiserModel.fromJson(value['data']);
        notifyListeners();
      }
    });
  }

  getCategories(context) async {
    setLoadingPage(true);
    await fundraiserServices.getCategory(context).then((value) {
      print(value);
      setLoadingPage(false);
      if (value['status'] == true) {
        _categoryModel = CategoryModel.fromJson(value['data']);
        notifyListeners();
      }
    });
  }

  getSingleFundraisers(context, id) async {
    setLoadingPage(true);
    await fundraiserServices.getSingleFundraiser(context, id).then((value) {
      setLoadingPage(false);
      if (value['status'] == true) {
        _fundraiser = Fundraiser.fromJson(value['data']['fundraiser']);
        notifyListeners();
      }
    });
  }

  getAllInvestors(context) async {
    setLoadingPage(true);
    await fundraiserServices.getAllInvestors(context).then((value) {
      setLoadingPage(false);
      if (value['status'] == true) {
        _investorsResponse = InvestorsResponse.fromJson(value['data']);
        notifyListeners();
      }
    });
  }

  Future<bool> createCampaign(
      context, FundraiserRequest fundraiserRequest) async {
    bool isSuccess = false;
    show(context);
    await fundraiserServices
        .createFundraiser(context, fundraiserRequest.toJson())
        .then((value) {
      Loader.hide();
      if (value['status'] == true) {
        isSuccess = true;
        customDailog(
            isSuccess: true,
            message: 'Campaign created successful',
            title: 'Successful',
            icon: const Icon(Icons.warning_amber));
      }
    });
    return isSuccess;
  }

  Future<void> getMD5Hash(File file) async {
    // Directory directory = await getApplicationDocumentsDirectory();
    // File file = File('${directory.path}');
    String hash = await calculateMD5(file);
    print(hash);
  }

  Future<String> calculateMD5(File file) async {
    var md5s = md5.convert(await file.readAsBytes());
    return md5s.toString();
  }

  getFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      getMD5Hash(file);
    } else {
      // User canceled the picker
    }
  }
}
