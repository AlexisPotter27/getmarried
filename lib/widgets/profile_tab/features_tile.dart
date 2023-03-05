import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/feature_model.dart';

class FeaturesTile extends StatefulWidget {
  const FeaturesTile(
      {Key? key, required this.featureModel, required this.selectedFeature})
      : super(key: key);
  final FeatureModel featureModel;
  final int selectedFeature;

  @override
  State<FeaturesTile> createState() => _FeaturesTileState();
}

class _FeaturesTileState extends State<FeaturesTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children:  [
                    Text(
                      widget.featureModel.feature,
                      style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                    ),
                    const   SizedBox(
                      width: 8,
                    ),
                    const   Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.check,
                        size: 16,
                        color: widget.selectedFeature == 0
                            ? primaryColour
                            : Colors.grey,
                      ),

                      Visibility(
                        visible: widget.featureModel.plans.contains('boost'),
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: widget.selectedFeature == 1
                              ? primaryColour
                              : Colors.grey,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            indent: 2,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
