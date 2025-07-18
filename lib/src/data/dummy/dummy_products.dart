import 'package:ecommerce_with_bloc/src/data/model/product_model.dart';

final List<ProductModel> dummyProducts = [
  ProductModel(
    productName: "Winter T-shirt",
    productPrice: 200.0,
    imageGallery: [
      ImageGallery(
        title: "Image-1",
        url:
            "https://images.othoba.com/images/thumbs/0574991_winter-long-full-sleeves-t-shirt.jpeg",
      ),

      ImageGallery(
        title: "Image-2",
        url:
            "https://images.othoba.com/images/thumbs/0574988_winter-long-full-sleeves-t-shirt.jpeg",
      ),
    ],
    varient: [
      Varient(
        category: "Size",
        items: [
          VarientItem(title: "S", description: ""),
          VarientItem(title: "M", description: ""),
          VarientItem(title: "XL", description: ""),
        ],
      ),
    ],
    productDetails: """
          Winter Long Full Sleeves T shirt  
          Item code: WST-13
          Material: Propylene
          Sleeve: Full Sleeve
          Style: Casual
          Made in Bangladesh
          Color: As given picture
          Size- M, L, XL
          """,
    productId: '',
  ),
];
