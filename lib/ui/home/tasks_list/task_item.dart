import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10) ,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20)
      ),
      
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: DrawerMotion(),
          children: [
            SlidableAction(onPressed: (buildContext){

            },
            backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],

        ),
        child: Container(
          padding: EdgeInsets.all(10),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
           child: Row(
             children: [
           Container(
             height: 80,
           width: 8,
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),),
               SizedBox(width: 8,),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('this is title',style: Theme.of(context).textTheme.headline6!.copyWith(
                       color: Theme.of(context).primaryColor
                     ),),
                     Text('this is description'),
                   ],
                 ),
               ),
               SizedBox(width: 8,),
               Container(
                 padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(18),
                   color: Theme.of(context).primaryColor,
                 ),child: Icon(Icons.check,color: Colors.white,size: 36,)
                 )
             ],
           ),
        ),
      ),
    );
  }
}
