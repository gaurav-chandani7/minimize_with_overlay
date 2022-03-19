import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimize_with_overlay/dto/video_list_item_dto.dart';
import 'package:minimize_with_overlay/pages/subpage_1.dart';
import 'package:minimize_with_overlay/provider_models/app_state_model.dart';
import 'package:provider/src/provider.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  List<VideoListItemDTO> videosList = [
    VideoListItemDTO(
        id: 1,
        title: "Big Buck Bunny",
        url:
            "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8"),
    VideoListItemDTO(
        id: 2,
        title: "Sintel",
        url:
            "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8"),
    VideoListItemDTO(
        id: 3,
        title: "Dummy video",
        url:
            "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"),
    VideoListItemDTO(
        id: 4,
        title: "Folgers",
        url:
            "http://cdnbakmi.kaltura.com/p/243342/sp/24334200/playManifest/entryId/0_uka1msg4/flavorIds/1_vqhfu6uy,1_80sohj7p/format/applehttp/protocol/http/a.m3u8")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.brown.shade300,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          CupertinoButton(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "To subpage 1",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      CupertinoIcons.chevron_forward,
                    )
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const SubPage1()));
              }),
          const SizedBox(
            height: 30,
          ),
          const Text("Videos List",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          Expanded(
            child: ListView.builder(
                itemCount: videosList.length,
                itemBuilder: (context, index) => Material(
                      child: ListTile(
                        title: Text(videosList[index].title),
                        trailing: const Icon(CupertinoIcons.play_arrow_solid),
                        onTap: () {
                          if (context
                                  .read<AppStateModel>()
                                  .activeVideoListItem ==
                              videosList[index]) {
                            if (context
                                .read<AppStateModel>()
                                .isVideoMinimized) {
                              context
                                  .read<AppStateModel>()
                                  .setIsVideoMinimized(false);
                            }
                          } else {
                            context.read<AppStateModel>().setIsVideoStarted(
                                flag: true, videoListItem: videosList[index]);
                          }
                        },
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
