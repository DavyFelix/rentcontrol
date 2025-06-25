# 📊 RentControl – Gerenciamento de Contas de Aluguel

RentControl é um aplicativo desenvolvido em Flutter que permite ao **locatário** controlar de forma prática as **contas mensais de aluguel** de diferentes imóveis. O sistema também abre possibilidades futuras para que **inquilinos** acompanhem o andamento dos pagamentos, promovendo **transparência, organização e segurança** para ambas as partes.

---

## 🧠 Ideia por trás do projeto

A proposta inicial do RentControl é oferecer ao **locatário** uma ferramenta intuitiva para registrar, acompanhar e atualizar o status de contas (Pagas, Pendentes ou Canceladas) relacionadas a cada casa ou imóvel alugado.

Futuramente, o sistema contará com **hierarquia de permissões**, permitindo a diferenciação entre os acessos do **locatário** e do **inquilino**, com cada um visualizando apenas as informações relevantes.

---

## 🚀 Funcionalidades

- ✅ Cadastro de imóveis (nome, bairro e rua)
- 📅 Lançamento mensal de contas (valor, mês, ano e status)
- 🔄 Atualização e exclusão de contas
- 📍 Obtenção automática de localização para preenchimento de endereço
- 🔒 Sistema de autenticação (cadastro e login com Firebase Auth)
- 📡 Integração com Firebase Firestore em tempo real
- 🧭 Interface amigável e responsiva para diferentes dispositivos

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** – UI e lógica do app
- **Firebase Firestore** – Armazenamento de dados
- **Firebase Auth** – Autenticação de usuários
- **Geolocator** – Obtenção da localização via GPS
- **Nominatim API (OpenStreetMap)** – Conversão de coordenadas em endereços
- **Provider** – Gerenciamento de estado
- **Gradle + Keytool** – Assinatura de builds para publicação

---

## 📸 Capturas de Tela 

**Tela Login**
![Tela Login](assets/images_readme/login_page.png)

**Tela Home**
![Tela Home](assets/images_readme/HomePage.png)

**Tela de Contas**
![Tela Contas](assets/images_readme/contasPage.png)

**Adicionar Conta**
![Sobre Page](assets/images_readme/contasDialogADD.png.png)

**Editar Conta**
![Sobre Page](assets/images_readme/contaDialogEDIT.png)

**Cadastro de Usuarios**
![Cadastro Conta](assets/images_readme/cadastroPage.png)

**Drawer Menu**
![Drawer Menu](assets/images_readme/drawer.png)

**Sobre Page**
![Sobre Page](assets/images_readme/sobrePage.png)

**Firestore com os dados**
![firestore1](assets/images_readme/firestore1.png)
![firestore2](assets/images_readme/firestore2.png)


## 📸 Videos
![video1](assets/Videos/Controle%20de%20Aluguel%20-%20Google%20Chrome%202025-06-24%2021-57-31.mp4)
![video2](assets/Videos/Controle%20de%20Aluguel%20-%20Google%20Chrome%202025-06-24%2023-12-31.mp4)
![video3](assets/Videos/RentalControl%20-%20Authentication%20-%20Usuários%20-%20Console%20do%20Firebase%20e%20mais%206%20páginas%20-%20Pessoal%20—%20Microsoft​%20Edge%202025-06-24%2023-13-20.mp4)
![video4](assets/Videos/RentalControl%20-%20Cloud%20Firestore%20-%20Dados%20-%20Console%20do%20Firebase%20-%20Google%20Chrome%202025-06-24%2022-01-22.mp4)


## 📦 Como executar

1. **Clone o repositório**  
   ```bash
   git clone https://github.com/seu-usuario/rentcontrol.git
   cd rentcontrol
## Cobertura de Teste
**Cabertura de Teste**
![Corbertura de Testes](assets/images_readme/cobertura%20de%20Testes.png)
