// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDo{

    struct todo{

        string text;

        bool completed;

    }

    todo[] todos;

    function addTodo(string calldata t) external {

        todos.push(todo({text:t, completed: false}));

    }

    function update(uint index, string calldata t) external {

        todos[index].text = t;

    }
    function statChange(uint index, bool stat)external {
        todos[index].completed = stat;
    }

    function getTodo(uint index) public  view returns (string memory, bool){
        return (todos[index].text, todos[index].completed);
    }

    function toggleCompleted(uint index) external {
        todos[index].completed = !todos[index].completed; 
    }
  

}
