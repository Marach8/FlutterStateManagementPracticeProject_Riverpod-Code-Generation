import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_app/firebase_fields.dart';
import 'package:instagram_clone_app/likes/likes.dart';
import 'package:instagram_clone_app/likes/likes_dislike_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_dislike_post_provider.g.dart';

@riverpod
Future<bool> likeDislikePost(LikeDislikePostRef _, {required LikesDislikesRequest request}) async{
  final query = FirebaseFirestore.instance.collection(FirebaseCollectionName.likes)
    .where(FirebaseFieldName.postId, isEqualTo: request.postId)
    .where(FirebaseFieldName.userId, isEqualTo: request.likedBy).get();

  final hasLiked = await query.then((snapshot) => snapshot.docs.isNotEmpty);
  if(hasLiked){
    try{
      await query.then((snapshot)async{
        for (final doc in snapshot.docs){await doc.reference.delete();}
      });
      return true;
    } catch(_){
      return false;
    }
  } else{
    final like = Likes(
      postId: request.postId,
      likedBy: request.likedBy,
      dateTime: DateTime.now()
    );

    try{
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.likes).add(like);
      return true;
    } catch (_){
      return false;
    }
  }    
}