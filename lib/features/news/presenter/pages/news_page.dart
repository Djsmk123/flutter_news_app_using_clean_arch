import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presenter/bloc/news_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presenter/widgets/news_widgets.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('News App Clean Architecture'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchWidget(),
            BlocBuilder<NewsBloc,NewsState>(
              builder: (context,state){
                if(state is NewsLoading){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(state is NewsLoaded){
                  return ListView.builder(
                    itemCount: state.newsList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return NewsContainer(news: state.newsList[index]);
                    },
                  );
                }else if(state is NewsError){
                  return Center(child: Text(state.message),);
                }else{
                  return const Center(child: Text('Empty'),);
                }
              },
            ),
          ],
        ),
      )

    );
  }
  Widget searchWidget(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: _searchController,
        onChanged: (value){
          setState(() {
            searchQuery = value;
          });
        },
        decoration:  InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: searchQuery!=""?
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: (){
                _searchController.clear();
                setState(() {
                  searchQuery = '';
                });
                dispatchGetNewsEvent();
              },
            ):null
        ),
        onFieldSubmitted: (value){
            dispatchSearchEvent();
        },

      ),
    );
  }
  void dispatchSearchEvent(){
    BlocProvider.of<NewsBloc>(context).add(SearchNewsEvent( query: searchQuery));
  }
  void dispatchGetNewsEvent(){
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
  }
}
