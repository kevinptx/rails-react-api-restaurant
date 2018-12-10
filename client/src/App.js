import React, { Component } from "react";
import Menus from "./components/Menus";
import MenuForm from "./components/MenuForm";
import { Container, Button, Icon } from "semantic-ui-react";
import axios from "axios";

class App extends Component {
  state = {
    menus: [],
    showForm: false
  };

  toggleForm = () => this.setState({ showForm: !this.state.showForm });

  componentDidMount() {
    axios
      .get("/api/menus")
      .then(res => {
        this.setState({ menus: res.data });
      })
      .catch(err => {
        console.log(err);
      });
  }

  addMenu = name => {
    axios.post("/api/menus", { name }).then(res => {
      const { menus } = this.state;
      this.setState({ menus: [...menus, res.data] });
    });
  };

  updateMenu = (id, menu) => {
    axios.put(`/api/menus/${id.id}`, menu).then(res => {
      const menus = this.state.menus.map(m => {
        if (m.id === id) return res.data;
        return m;
      });
      this.setState({ menus });
    });
  };

  deleteMenu = id => {
    axios.delete(`/api/menus/${id}`).then(res => {
      const { menus } = this.state;
      this.setState({ menus: menus.filter(m => m.id !== id) });
    });
  };

  render() {
    const { showForm } = this.state;
    return (
      <Container style={{ padding: "30px 0" }}>
        <Button icon color="blue" onClick={this.toggleForm}>
          <Icon name={this.state.showForm ? "times" : "plus"} />
        </Button>
        New Menu
        {showForm ? <MenuForm addMenu={this.addMenu} /> : null}
        <Menus
          menus={this.state.menus}
          updateMenu={this.updateMenu}
          deleteMenu={this.deleteMenu}
        />
      </Container>
    );
  }
}

export default App;
