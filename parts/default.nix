{inputs, ...}: {
  systems = import inputs.systems;

  imports = [
    ./lib
    ./../hosts
  ];
}
