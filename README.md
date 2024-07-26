# Google Maps Marker Animation - Overview

Sometimes you need more than place a *Marker*📍 at map canvas 🌍, you need to smoothly move through **Google Maps**.

This package will help you to animate *Markers*' position changes and more.

This version v3.0.0 includes many useful features, namely:

 - Marker's position animation
 - Multiple markers' animations at the same time
 - Null-safety compatible
 - Ripple effect over marker position
 - Marker's rotation or bearing/heading of direction
 - Multipoint linear animation (*Piecewise Linear Approximation Algorithm*)
 - Support animation curves and duration
 - Widget-based with fully customized behaviors
 - Animation warm-up for improving performance
 - Useful **LocationTween**, **AngleTween** and **PolynomialLocationInterpolator** core logic

### Note
This package only animate the marker's changes. Both Geolocation and Google Maps configuration are out of the scope of this package. So, before trying this package to ensure that you place a marker you Google Map or get location updates.


## Screenshots

<img src="https://raw.githubusercontent.com/gauris26/flutter_animarker/d61ac4f420f030f4e002fa287282628d901cff26/arts/marker_animation.gif" width="300"/> <img src="https://raw.githubusercontent.com/gauris26/flutter_animarker/d61ac4f420f030f4e002fa287282628d901cff26/arts/multi_markers.gif" width="300"/>

## Example

```dart
  Animarker(
    ...
    curve: Curves.bounceInOut,
    duration: Duration(milliseconds: 2000),
    markers: <Marker> {
      RippleMarker(
        markerId: MarkerId('MarkerId2'),
        position: LatLng(0, 0),
        ripple: true,
      ),
    },
    child: GoogleMap(
      ...
      onMapCreated: (gController) => controller.complete(gController), //Complete the future GoogleMapController
      ...
    ),
    ...
  )
```

```dart
    //Setting dummies values
    const kStartPosition = LatLng(18.488213, -69.959186);
    const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
    const kMarkerId = MarkerId('MarkerId1');
    const kDuration = Duration(seconds: 2);
    const kLocations = [
      kStartPosition,
      LatLng(18.488101, -69.957995),
      LatLng(18.489210, -69.952459),
      LatLng(18.487307, -69.952759)
    ];

    class SimpleMarkerAnimationExample extends StatefulWidget {
      @override
      SimpleMarkerAnimationExampleState createState() => SimpleMarkerAnimationExampleState();
    }

    class SimpleMarkerAnimationExampleState extends State<SimpleMarkerAnimationExample> {
      final markers = <MarkerId, Marker>{};
      final controller = Completer<GoogleMapController>();
      final stream = Stream.periodic(kDuration, (count) => kLocations[count]).take(kLocations.length);

      @override
      void initState() {
        stream.forEach((value) => newLocationUpdate(value));

        super.initState();
      }

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Google Maps Markers Animation Example',
          home: Animarker(
            curve: Curves.ease,
            mapId: controller.future.then<int>((value) => value.mapId), //Grab Google Map Id
            markers: markers.values.toSet(),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: kSantoDomingo,
              onMapCreated: (gController) => controller.complete(gController), //Complete the future GoogleMapController
            ),
          ),
        );
      }

      void newLocationUpdate(LatLng latLng) {
         var marker = RippleMarker(
           markerId: kMarkerId,
           position: latLng,
           ripple: true,
         );
         setState(() => markers[kMarkerId] = marker);
      }
    }
 ```
## Using Ripple Effect

You only need to use the marker wrapper class ``` RippleMarker```, and set the ripple ```flag```  in order you can the ripple state.

```dart
  Animarker(
    // Other properties
    rippleRadius: 0.5,  //[0,1.0] range, how big is the circle
    rippleColor: Colors.teal, // Color of fade ripple circle
    rippleDuration: Duration(milliseconds: 2500), //Pulse ripple duration
    markers: <Marker>{
      //Ripple Marker
      RippleMarker(
        markerId: MarkerId('MarkerId1'),
        position: LatLng(0, 0),
        ripple: true,  //Ripple state
      ),
      //Non-ripple marker
      Marker(
        markerId: MarkerId('MarkerId2'),
        position: LatLng(0, 0),
      ),
    },
    // Other properties
  )
```
So, Let's it rip!

## Using Rotation

The Marker rotation can be useful for Uber-like or delivery apps. The bearing or heading is the angle of direction which the *Marker* is moving toward to over the earth.

```dart
  Animarker(
    // Other properties
    useRotation : true, // Actived by default
    markers: <Marker>{
      Marker(
      markerId: MarkerId('MarkerId2'),
      position: LatLng(0, 0),
      )
    },
  // Other properties
  )
```
This way ```useRotation = true```, you control globally if *Marker* should rotate or not.

## Using Curve and Duration

Just like a normal *Flutter* animation, you can set a ```Curve``` o ```Duration``` to get the desire effect or result. So flexible, right?

```dart
  Animarker(
    // Other properties
    curve: Curves.bounceInOut,
    duration: Duration(milliseconds: 2000),
    markers: <Marker>{
      Marker(
      markerId: MarkerId('MarkerId2'),
      position: LatLng(0, 0),
      ),
    },
    // Other properties
  )
```
