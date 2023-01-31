import 'package:delivery_service/controller/search_controller/search_bloc.dart';
import 'package:delivery_service/controller/search_controller/search_event.dart';
import 'package:delivery_service/model/restaurant_model/vendor_model.dart';
import 'package:delivery_service/ui/widgets/image_loading/image_loading.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVendorItem extends StatefulWidget {
  final VendorModel vendorModel;

  const SearchVendorItem({required this.vendorModel, Key? key})
      : super(key: key);

  @override
  State<SearchVendorItem> createState() => _SearchVendorItemState();
}

class _SearchVendorItemState extends State<SearchVendorItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _searchRestaurant,
      child: Card(
        color: getCurrentTheme(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageLoading(
                imageUrl: widget.vendorModel.image,
                imageWidth: 50,
                imageHeight: 50,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  widget.vendorModel.name,
                  style: getCurrentTheme(context).textTheme.displayMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchRestaurant() {
    context.read<SearchBloc>().add(SearchSaveHistoryEvent());
  }
}
