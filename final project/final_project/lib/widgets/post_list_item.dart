import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../screens/post_detail_screen.dart';
import 'package:intl/intl.dart';

// list item widget to display a post
class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // determine if there's an image or use a placeholder
    bool hasImage = post.imageUrls.isNotEmpty;
    String imageUrl = hasImage ? post.imageUrls[0] : '';

    // define text styles 
    const TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    const TextStyle subtitleStyle = TextStyle(
      fontSize: 14,
      color: Colors.white70,
    );
    const TextStyle priceStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 8), 
      decoration: BoxDecoration(
        color: Colors.deepPurple, 
        borderRadius: BorderRadius.circular(8), 
      ),
      child: InkWell(
        onTap: () {
          // navigate to post detail screen on tap
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0), 
          child: Row(
            children: [
              // left side: Image or Placeholder Icon
              Container(
                width: 60, 
                height: 60, 
                margin: const EdgeInsets.only(right: 12), 
                child: ClipRRect( 
                  borderRadius: BorderRadius.circular(8),
                  child: hasImage
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          // error handling for network images
                          errorBuilder: (context, error, stackTrace) {
                            return Container( 
                              color: Colors.white24,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 30,
                                  color: Colors.white70,
                                ),
                              ),
                            );
                          },
                          // placeholder while loading
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.white24,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            );
                          },
                        )
                      : Container( // placeholder if no image URL
                          color: Colors.white24,
                          child: const Center(
                            child: Icon(
                              Icons.attach_money, // paceholder icon like in the image
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
              // right side: Text details (Title, Subtitle, Price)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // center text vertically
                  children: [
                    Text(
                      post.title,
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4), 
                    Text(
                      post.description, // using description as subtitle
                      style: subtitleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // price on the far right
              Padding(
                padding: const EdgeInsets.only(left: 8.0), 
                child: Text(
                  '\$${post.price.toStringAsFixed(post.price.truncateToDouble() == post.price ? 0 : 2)}', // show decimal only if needed
                  style: priceStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}