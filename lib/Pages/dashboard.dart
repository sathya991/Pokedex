import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/Blocs/pokemon_bloc.dart';
import 'package:pokedex/Blocs/pokemon_event.dart';
import 'package:pokedex/Blocs/pokemon_state.dart';
import 'package:pokedex/Blocs/type_bloc.dart';
import 'package:pokedex/Models/all_pokemon_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeBloc, PokemonStates>(builder: (context, outerState) {
      var curType = 0;
      var clicked = false;
      var curPage = BlocProvider.of<PokemonBloc>(context).curPage;
      var curTypePage = BlocProvider.of<PokemonBloc>(context).curTypePage;
      if (outerState is MenuState) {
        clicked = outerState.clicked;
        if (outerState.type != 0) {
          curType = outerState.type;
        }
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex"),
          actions: [
            DropdownButton(
                dropdownColor: Colors.red,
                underline: const Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 20),
                value: pokemonTypes[curType],
                items: pokemonTypes.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (a) {
                  BlocProvider.of<PokemonBloc>(context).curPage = 0;
                  BlocProvider.of<PokemonBloc>(context).curTypePage = 0;
                  var curChoose = pokemonTypes.indexOf(a.toString());
                  if (curChoose != 0) {
                    BlocProvider.of<TypeBloc>(context).add(
                        PokemonTypePageRequest(
                            page: 0,
                            clicked: true,
                            type: curChoose,
                            name: a.toString()));
                  } else {
                    BlocProvider.of<TypeBloc>(context).add(
                        PokemonTypePageRequest(
                            clicked: true, page: 0, type: 0, name: "All"));
                  }
                })
          ],
        ),
        body:
            BlocBuilder<PokemonBloc, PokemonStates>(builder: (context, state) {
          if (curType != 0 && clicked) {
            BlocProvider.of<TypeBloc>(context).add(PokemonTypePageRequest(
                page: 0,
                clicked: false,
                type: curType,
                name: pokemonTypes[curType].toString()));
            BlocProvider.of<PokemonBloc>(context).add(PokemonTypePageRequest(
                page: curPage,
                clicked: false,
                type: curType,
                name: pokemonTypes[curType].toString()));
          } else if (curType == 0 && clicked) {
            BlocProvider.of<TypeBloc>(context).add(PokemonTypePageRequest(
                clicked: false, page: 0, type: 0, name: "All"));
            BlocProvider.of<PokemonBloc>(context)
                .add(PokemonPageRequest(page: curPage));
          }
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedState) {
            return SmartRefresher(
              // enablePullDown: true,
              enablePullUp: true,
              controller:
                  BlocProvider.of<PokemonBloc>(context).refreshController,
              onRefresh: () {
                if (curType == 0) {
                  BlocProvider.of<PokemonBloc>(context)
                      .add(PokemonPageRequest(page: 0));
                } else {
                  BlocProvider.of<PokemonBloc>(context).add(
                      PokemonTypePageRequest(
                          page: 0,
                          type: curType,
                          clicked: clicked,
                          name: pokemonTypes[curType].toString()));
                }
              },
              onLoading: () {
                if (curType == 0) {
                  BlocProvider.of<PokemonBloc>(context)
                      .add(PokemonPageRequest(page: curPage + 1));
                } else {
                  BlocProvider.of<PokemonBloc>(context).add(
                      PokemonTypePageRequest(
                          page: curTypePage + 1,
                          type: curType,
                          clicked: clicked,
                          name: pokemonTypes[curType].toString()));
                }
                BlocProvider.of<PokemonBloc>(context)
                    .refreshController
                    .loadComplete();
              },
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: state.pokemonlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: GridTile(
                            child: Column(
                          children: [
                            Image.network(
                              state.pokemonlist[index].imageUrl,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/pokeball.png',
                                  height: 100,
                                );
                              },
                              height: 100,
                            ),
                            Text(state.pokemonlist[index].name)
                          ],
                        )),
                      ),
                    );
                  }),
            );
          } else if (state is FailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error.toString()),
                  ElevatedButton(
                      onPressed: () {
                        if (curType != 0) {
                          BlocProvider.of<TypeBloc>(context).add(
                              PokemonTypePageRequest(
                                  page: 0,
                                  clicked: true,
                                  type: curType,
                                  name: pokemonTypes[curType].toString()));
                        } else {
                          BlocProvider.of<TypeBloc>(context).add(
                              PokemonTypePageRequest(
                                  clicked: true,
                                  page: 0,
                                  type: 0,
                                  name: "All"));
                        }
                      },
                      child: Text("Retry")),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      );
    });
  }
}
