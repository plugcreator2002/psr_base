#### multiple_user_interface is to separate the appearance of tablet, mobile and desktop

#### import this line
    import 'package:psr_base/plugin_emulators/multiple_user_interface/index.dart';

#### if you want separate the pages -> first use this
    BaseWidgets(
        builder: (context, information) {
            return Scaffold(
                body: ScreenTypeLayout(
                    desktop: OrientationLayout(
                      portrait: LoginDesktop(),
                      landscape: LoginDesktop(),
                    ),
                    tablet: OrientationLayout(
                      portrait: LoginTablet(),
                      landscape: LoginTablet(),
                    ),
                    mobile: OrientationLayout(
                      portrait: LoginMobile(),
                      landscape: LoginMobile(),
                    ),
                ),
            );
        }
    )

#### if you just want separate the widgets -> use this
    ScreenTypeLayout(
        desktop: Scaffold(backgroundColor: Colors.white),
        tablet: SizedBox(),
        mobile: OrientationLayout(
          portrait: SizedBox(),
          landscape: SizedBox(),
        ),
    )
