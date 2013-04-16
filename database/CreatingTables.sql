
--
-- Banco de Dados: `genpen`
--

-- --------------------------------------------------------

-- Estrutura da tabela `penitenciaria`

CREATE TABLE `penitenciaria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `orgao` varchar(50) NOT NULL,
  `sigla` varchar(50) NOT NULL,
  `cnpj` int(14) UNIQUE NOT NULL,
  `responsavel` varchar(50) NOT NULL,
  `seguranca` varchar(30) NOT NULL,
  `telefone` int(11) NOT NULL,
  `endereco` varchar(50) NOT NULL,
  `uf` varchar(50) NOT NULL,
  `municipio` varchar(50) NOT NULL,
  `distrito` varchar(50) NOT NULL,
  `cep` int(8) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `preso`

CREATE TABLE `preso` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sexo` varchar(10) NOT NULL,
  `cor_pele` varchar(10) NOT NULL,
  `tipo_sanguineo` varchar(7) DEFAULT NULL,
  `distrito` varchar(30) NOT NULL,
  `municipio` varchar(30) NOT NULL,
  `uf` varchar(20) NOT NULL,
  `nacionalidade` varchar(20) NOT NULL,
  `data_nascimento` date NOT NULL,
  `observacoes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `fornecedor`

CREATE TABLE `fornecedor` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cnpj` int(11) UNIQUE NOT NULL,
  `telefone` int(11) NOT NULL,
  `endereco` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `uf` varchar(50) NOT NULL,
  `cep` int(8) NOT NULL,
  PRIMARY KEY (`id`)
);
-- Estrutura da tabela `advogado`

CREATE TABLE `advogado` (
  `registro_oab` int(10) NOT NULL,
  `uf_oab` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`registro_oab`)
);

-- Estrutura da tabela `cela`

CREATE TABLE `cela` (
  `id` int(10) NOT NULL,
  `capacidade` int(3) NOT NULL,
  `cubagem` int(3) NOT NULL,
  `area` int(3) NOT NULL,
  `diametro` int(3) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `crime`

CREATE TABLE `crime` (
  `id` int(10) NOT NULL,
  `artigo` varchar(50) NOT NULL,
  `paragrafo` varchar(50) NOT NULL,
  `pena` int(3) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `funcionario`

CREATE TABLE `funcionario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cpf` int(10) UNIQUE NOT NULL,
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `sexo` varchar(9) NOT NULL,
  `nome_mae` varchar(50) NOT NULL,
  `nome_pai` varchar(50) NOT NULL,
  `rg` int(10) NOT NULL,
  `nacionaliade` varchar(50) NOT NULL,
  `uf_nascimento` varchar(19) NOT NULL,
  `orgao_expeditor` varchar(30) NOT NULL,
  `estado_civil` varchar(15) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `telefone` int(11) NOT NULL,
  `naturalidade` varchar(50) NOT NULL,
  `endereco` varchar(40) NOT NULL,
  `uf` varchar(19) NOT NULL,
  `cidade` varchar(30) NOT NULL,
  `cep` int(8) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `dados_funcionais`

CREATE TABLE `dados_funcionais` (
  `id_funcionario` int(10) NOT NULL,
  `matricula` int(10) UNIQUE NOT NULL,
  `cargo` varchar(30) NOT NULL,
  `data_ingresso` date NOT NULL,
  `data_saida` date NOT NULL,
  `situacao` varchar(15) NOT NULL,
  `horario_expediente` varchar(20) NOT NULL,
  `orgao_vinculado` int(7) NOT NULL,
  `setor` varchar(30) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  CONSTRAINT `FK_dados_funcionais_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `ficha_social`

CREATE TABLE `ficha_social` (
  `id_preso` int(10) NOT NULL AUTO_INCREMENT,
  `estado_civil` varchar(20) NOT NULL,
  `gestante` varchar(1) NOT NULL,
  `necessidades_especiais` varchar(20) NOT NULL,
  `grau_instrucao` varchar(20) NOT NULL,
  `religiao` varchar(20) NOT NULL,
  `profissao` varchar(20) NOT NULL,
  `outras_habilidades` varchar(20) NOT NULL,
  PRIMARY KEY (`id_preso`),
  CONSTRAINT `FK_ficha_social_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `prontuario`

CREATE TABLE `prontuario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `alcunha` varchar(50) NOT NULL,
  `regime` varchar(50) NOT NULL,
  `foto_perfil` blob NOT NULL,
  `foto_frente` blob NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_prontuario_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `parente`

CREATE TABLE `parente` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `tipo_parentesco` varchar(15) NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_parente_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `biometria`

CREATE TABLE `biometria` (
  `dedo_e1` varchar(512) NULL,
  `dedo_e2` varchar(512) NULL,
  `dedo_e3` varchar(512) NULL,
  `dedo_e4` varchar(512) NULL,
  `dedo_e5` varchar(512) NULL,
  `dedo_d1` varchar(512) NULL,
  `dedo_d2` varchar(512) NULL,
  `dedo_d3` varchar(512) NULL,
  `dedo_d4` varchar(512) NULL,
  `dedo_d5` varchar(512) NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id_preso`),
  CONSTRAINT `FK_biometria_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `pena`

CREATE TABLE `pena` (
  `id_preso` int(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NULL,
  PRIMARY KEY (`id_preso`),
  CONSTRAINT `FK_pena_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `visita`

CREATE TABLE `visita` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL,
  `data` date NOT NULL,
  `duracao` time NOT NULL,
  `id_parente` int(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_visita_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_visita_parente` FOREIGN KEY (`id_parente`) REFERENCES `parente` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `roupa`

CREATE TABLE `roupa` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL,
  `descricao` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_roupa_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `lavanderia`

CREATE TABLE `lavanderia` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_lavanderia_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `entrada_lavanderia`

CREATE TABLE `entrada_lavanderia` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `data_entrega` date NOT NULL,
  `data_saida` date NOT NULL,
  `responsavel_entrega` varchar(30) NOT NULL,
  `responsavel_saida` varchar(30) NOT NULL,
  `id_roupa` int NOT NULL,
  `id_lavanderia` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_lavanderia_roupa` FOREIGN KEY (`id_roupa`) REFERENCES `roupa` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_lavanderia_lavanderia` FOREIGN KEY (`id_lavanderia`) REFERENCES `lavanderia` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `enfermaria`

CREATE TABLE `enfermaria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_enfermaria_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `entrada_enfermaria`

CREATE TABLE `entrada_enfermaria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL, 
  `id_enfermaria` int(10) NOT NULL, 
  `status` varchar(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `matricula_medico` int(10) NOT NULL,
  `diagnostico_entrega` varchar(30) NOT NULL,
  `diagnostico_saida` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_enfermaria_dados_funcionais` FOREIGN KEY (`matricula_medico`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_enfermaria_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_enfermaria_enfermaria` FOREIGN KEY (`id_enfermaria`) REFERENCES `enfermaria` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `apoio_didatico`

CREATE TABLE `apoio_didatico` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_apoio_didatico_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `entrada_apoio`

CREATE TABLE `entrada_apoio` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL, 
  `id_apoio_didatico` int(10) NOT NULL, 
  `tipo_apoio` varchar(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `matricula_instrutor` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_apoio_dados_funcionais` FOREIGN KEY (`matricula_instrutor`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_apoio_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_apoio_apoio` FOREIGN KEY (`id_apoio_didatico`) REFERENCES `apoio_didatico` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `almoxarifado`

CREATE TABLE `almoxarifado` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_penitenciaria` int NOT NULL,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_almoxarifado_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `produto`

CREATE TABLE `produto` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(11) NOT NULL,
  `quantidade` int(10) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `entrada_almoxarifado`

CREATE TABLE `entrada_almoxarifado` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_produto` int(10) NOT NULL, 
  `id_almoxarifado` int(10) NOT NULL, 
  `id_fornecedor` int(10) NOT NULL, 
  `data_entrada` date NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_almoxarifado_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_almoxarifado_almoxarifado` FOREIGN KEY (`id_almoxarifado`) REFERENCES `almoxarifado` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_almoxarifado_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `cela_has_preso`

CREATE TABLE `cela_has_preso` (
  `id_cela` int(10) NOT NULL, 
  `id_preso` int(10) NOT NULL, 
  `data_entrada` date NOT NULL,
  PRIMARY KEY (`id_cela`,`id_preso`,`data_entrada`),
  CONSTRAINT `FK_cela_has_preso_cela` FOREIGN KEY (`id_cela`) REFERENCES `cela` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_cela_has_preso_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `prontuario_has_crime`

CREATE TABLE `prontuario_has_crime` (
  `id_prontuario` int(10) NOT NULL, 
  `id_crime` int(10) NOT NULL, 
  PRIMARY KEY (`id_prontuario`,`id_crime`),
  CONSTRAINT `FK_prontuario_has_crime_prontuario` FOREIGN KEY (`id_prontuario`) REFERENCES `prontuario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_prontuario_has_crime_crime` FOREIGN KEY (`id_crime`) REFERENCES `crime` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `preso_has_advogado`

CREATE TABLE `preso_has_advogado` (
  `id_preso` int(10) NOT NULL, 
  `id_advogado` int(10) NOT NULL, 
  PRIMARY KEY (`id_preso`,`id_advogado`),
  CONSTRAINT `FK_preso_has_advogado_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_preso_has_advogado_advogado` FOREIGN KEY (`id_advogado`) REFERENCES `advogado` (`registro_oab`) ON DELETE RESTRICT ON UPDATE CASCADE
);
