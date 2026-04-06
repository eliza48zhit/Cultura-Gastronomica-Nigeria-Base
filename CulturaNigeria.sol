// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaNigeria
 * @dev Registro de la arquitectura de sopas y espesantes nigerianos.
 * Serie: Sabores de Africa (3/54)
 */
contract CulturaNigeria {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        string tipoEspesante;     // Ej: Egusi, Ogbono, Name, Achi
        bool usaAceitePalma;      // Identificador de lipido base (Rojo)
        uint256 nivelPicante;     // Escala 1-10 (Uso de Scotch Bonnet)
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        registrarPlato(
            "Egusi Soup", 
            "Semillas de melon molidas, espinacas, carne de res, pescado seco.",
            "Tostar semillas en aceite de palma, anadir caldo y espesar hasta obtener grumos.",
            "Egusi (Semilla de Melon)", 
            true, 
            7
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        string memory _espesante, 
        bool _palma,
        uint256 _picante
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_picante <= 10, "Escala picante: 0 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            tipoEspesante: _espesante,
            usaAceitePalma: _palma,
            nivelPicante: _picante,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    /**
     * @dev Consulta ampliada para incluir Ingredientes y Preparacion.
     */
    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        string memory ingredientes,
        string memory preparacion,
        string memory espesante,
        bool palma,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (
            p.nombre, 
            p.ingredientes, 
            p.preparacion, 
            p.tipoEspesante, 
            p.usaAceitePalma, 
            p.likes
        );
    }
}
