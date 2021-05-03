import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
 List<CameraDescription> cameras;
  CameraController _cameraController ;
  List<dynamic> _galleryPhotos;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    initializeCamera();
    // getImagesFromGallery();
    super.initState();
    
  }

  Future<void> initializeCamera()async{
    cameras = await availableCameras();
    _cameraController=CameraController(cameras[0],ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      if (!mounted) return;
      setState(() {});
    });
    _initializeControllerFuture = _cameraController.initialize();
  }

  // Future<void> getImagesFromGallery()async{
  //   final customImagePicker = CustomImagePicker();
  //   customImagePicker.getAllImages(callback: (retrievedAlbums) {
  //       _galleryPhotos = retrievedAlbums;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    // if (_cameraController==null || !_cameraController.value.isInitialized){
    //   return Container(height: 0.0,width: 0.0,);
    // }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(_cameraController),
          ),
          _cameraButtonWidget(),
          // _galleryWidget(),
        ],
      ),
    );
  }

  Widget _cameraButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.flash_on,color: Colors.white,size: 30,),
            InkWell(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(color: Colors.white,width: 2)
                ),
              ),
              onTap: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _cameraController.takePicture();

                  // If the picture was taken, display it on a new screen.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image?.path,
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
            Icon(Icons.camera_alt,size: 30,color: Colors.white,)
          ],
        ),
      ),
    );
  }
  Widget _galleryWidget() {
    return Positioned(
      bottom: 100,
      right: 0,
      left: 0,
      child: Container(
        height: 55,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _galleryPhotos.length,
          itemBuilder: (_,index){
            return Container(
              margin: EdgeInsets.only(right: 8),
              height: 55,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.2)
              ),
              child: Image.file(File(_galleryPhotos[index]),fit: BoxFit.cover,),
            );
          },
        ),
      ),
    );
  }
}


class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        backgroundColor: Theme.of(context).accentColor,
        // Provide an onPressed callback.
        onPressed: () async {
          
        },
      ),
    );
  }
}