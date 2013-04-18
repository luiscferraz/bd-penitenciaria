--
-- Banco de Dados: `genpen`
--

-- --------------------------------------------------------


DROP SCHEMA IF EXISTS `genpen` ;
CREATE SCHEMA IF NOT EXISTS `genpen` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `genpen` ;



-- Estrutura da tabela `endereco`
--

CREATE TABLE `genpen`.`endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rua` varchar(50) NOT NULL,
  `numero` varchar(6) NOT NULL,
  `complemento` varchar(100)DEFAULT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `cep` int(8) NOT NULL,
  PRIMARY KEY (`id`)
);



-- Estrutura da tabela `penitenciaria`

CREATE TABLE `genpen`.`penitenciaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `orgao` varchar(50) NOT NULL,
  `sigla` varchar(50) NOT NULL,
  `cnpj` bigint(14) UNIQUE NOT NULL,
  `responsavel` varchar(50) NOT NULL,
  `seguranca` varchar(30) NOT NULL ,
  `telefone` bigint(11) NOT NULL,
  `id_endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
   CONSTRAINT `FK_penitenciaria_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `preso`

CREATE TABLE `genpen`.`preso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cpf` bigint(11) UNIQUE NOT NULL,
  `rg` int(8) UNIQUE NOT NULL,
  `sexo` ENUM('M','F') NOT NULL,
  `cor_pele` varchar(10) NOT NULL,
  `tipo_sanguineo` varchar(7) DEFAULT NULL,
  `nacionalidade` varchar(20) NOT NULL,
  `data_nascimento` date NOT NULL,
  `observacoes` varchar(50) DEFAULT NULL,
  `id_endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_preso_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `fornecedor`

CREATE TABLE `genpen`.`fornecedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cnpj` bigint(11) UNIQUE NOT NULL,
  `telefone` bigint(11) NOT NULL,
  `id_endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_fornecedor_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Estrutura da tabela `advogado`

CREATE TABLE `genpen`.`advogado` (
  `registro_oab` int(7) NOT NULL,
  `uf_oab` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`registro_oab`)
);

-- Estrutura da tabela `cela`

CREATE TABLE `genpen`.`cela` (
  `id` int(5) NOT NULL ,
  `capacidade` int(3) NOT NULL,
  `cubagem` int(3) NOT NULL,
  `area` int(3) NOT NULL,
  `diametro` int(3) NOT NULL,
  `localizacao` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `crime`

CREATE TABLE `genpen`.`crime` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artigo` varchar(50) NOT NULL,
  `paragrafo` varchar(50) NOT NULL,
  `pena` int(3) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `funcionario`

CREATE TABLE `genpen`.`funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cpf` bigint(10) UNIQUE NOT NULL,
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `sexo`ENUM('M','F') NOT NULL,
  `nome_mae` varchar(50) DEFAULT NULL,
  `nome_pai` varchar(50) DEFAULT NULL,
  `rg` bigint(10) UNIQUE NOT NULL,
  `nacionaliade` varchar(50) NOT NULL,
  `uf_nascimento` varchar(19) NOT NULL,
  `orgao_expeditor` varchar(30) NOT NULL,
  `estado_civil` varchar(15) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `telefone` bigint(11) DEFAULT NULL,
  `naturalidade` varchar(50) NOT NULL,
  `id_endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_funcionario_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `dados_funcionais`

CREATE TABLE `genpen`.`dados_funcionais` (
  `id_funcionario` int(10) NOT NULL,
  `matricula` int(10) UNIQUE NOT NULL,
  `cargo` varchar(30) NOT NULL,
  `data_ingresso` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  `situacao` varchar(15) NOT NULL,
  `horario_expediente` varchar(20) NOT NULL,
  `orgao_vinculado` int(7) DEFAULT NULL,
  `setor` varchar(30) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  CONSTRAINT `FK_dados_funcionais_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `Setor`
CREATE TABLE `genpen`.`setor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` bigint(11) DEFAULT NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `departamento` ENUM('enfermaria','almoxarifado', 'lavanderia', 'apoio_didatico') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_setor_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE
);



-- Estrutura da tabela `ficha_social`

CREATE TABLE `genpen`.`ficha_social` (
  `id_preso` int NOT NULL AUTO_INCREMENT,
  `estado_civil` varchar(20) NOT NULL,
  `gestante` varchar(1) NOT NULL,
  `necessidades_especiais` varchar(20) DEFAULT NULL,
  `grau_instrucao` varchar(20) DEFAULT NULL,
  `religiao` varchar(20) DEFAULT NULL,
  `profissao` varchar(20) DEFAULT NULL,
  `outras_habilidades` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_preso`),
  CONSTRAINT `FK_ficha_social_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `prontuario`

CREATE TABLE `genpen`.`prontuario` (
  `alcunha` varchar(50) NOT NULL,
  `regime` varchar(50) NOT NULL,
  `foto_perfil` blob NOT NULL,
  `foto_frente` blob NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id_preso`),
  CONSTRAINT `FK_prontuario_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `parente`

CREATE TABLE `genpen`.`parente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tipo_parentesco` varchar(15) NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_parente_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `biometria`

CREATE TABLE `genpen`.`biometria` (
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

CREATE TABLE `genpen`.`pena` (
  `id_preso` int(7) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NULL,
  PRIMARY KEY (`id_preso`,`data_entrada`),
  CONSTRAINT `FK_pena_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `visita`

CREATE TABLE `genpen`.`visita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preso` int(7) NOT NULL,
  `data` date NOT NULL,
  `duracao` time NOT NULL,
  `id_parente` int(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_visita_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_visita_parente` FOREIGN KEY (`id_parente`) REFERENCES `parente` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `roupa`

CREATE TABLE `genpen`.`roupa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preso` int(7) NOT NULL,
  `descricao` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_roupa_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Estrutura da tabela `entrada_lavanderia`

CREATE TABLE `genpen`.`entrada_lavanderia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `data_entrega` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  `responsavel_entrega` varchar(30) NOT NULL,
  `responsavel_saida` varchar(30) DEFAULT NULL,
  `id_roupa` int NOT NULL,
  `id_lavanderia` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_lavanderia_roupa` FOREIGN KEY (`id_roupa`) REFERENCES `roupa` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_lavanderia_setor` FOREIGN KEY (`id_lavanderia`) REFERENCES `setor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Estrutura da tabela `entrada_enfermaria`

CREATE TABLE `genpen`.`entrada_enfermaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preso` int(7) NOT NULL, 
  `id_enfermaria` int(7) NOT NULL, 
  `status` varchar(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  `matricula_medico` int(7) NOT NULL,
  `diagnostico_entrega` varchar(30) NOT NULL,
  `diagnostico_saida` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_enfermaria_dados_funcionais` FOREIGN KEY (`matricula_medico`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_enfermaria_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_enfermaria_setor` FOREIGN KEY (`id_enfermaria`) REFERENCES `setor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `entrada_apoio`

CREATE TABLE `genpen`.`entrada_apoio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL, 
  `id_apoio_didatico` int(10) NOT NULL, 
  `tipo_apoio` varchar(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  `matricula_instrutor` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_apoio_dados_funcionais` FOREIGN KEY (`matricula_instrutor`) REFERENCES `dados_funcionais` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_apoio_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_apoio_setor` FOREIGN KEY (`id_apoio_didatico`) REFERENCES `setor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- Estrutura da tabela `produto`

CREATE TABLE `genpen`.`produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(11) NOT NULL,
  `quantidade` int(10) NOT NULL,
  PRIMARY KEY (`id`)
);

-- Estrutura da tabela `entrada_almoxarifado`

CREATE TABLE `genpen`.`entrada_almoxarifado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_produto` int(10) NOT NULL, 
  `id_almoxarifado` int(10) NOT NULL, 
  `id_fornecedor` int(10) NOT NULL, 
  `data_entrada` date NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_entrada_almoxarifado_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_almoxarifado_setor` FOREIGN KEY (`id_almoxarifado`) REFERENCES `setor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_entrada_almoxarifado_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `cela_has_preso`

CREATE TABLE `genpen`.`cela_has_preso` (
  `id_cela` int(10) NOT NULL, 
  `id_preso` int(10) NOT NULL, 
  `data_entrada` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  PRIMARY KEY (`id_cela`,`id_preso`,`data_entrada`),
  CONSTRAINT `FK_cela_has_preso_cela` FOREIGN KEY (`id_cela`) REFERENCES `cela` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_cela_has_preso_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `prontuario_has_crime`

CREATE TABLE `genpen`.`prontuario_has_crime` (
  `id_prontuario` int(10) NOT NULL, 
  `id_crime` int(10) NOT NULL, 
  PRIMARY KEY (`id_prontuario`,`id_crime`),
  CONSTRAINT `FK_prontuario_has_crime_prontuario` FOREIGN KEY (`id_prontuario`) REFERENCES `prontuario` (`id_preso`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_prontuario_has_crime_crime` FOREIGN KEY (`id_crime`) REFERENCES `crime` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Estrutura da tabela `preso_has_advogado`

CREATE TABLE `genpen`.`preso_has_advogado` (
  `id_preso` int(10) NOT NULL, 
  `id_advogado` int(10) NOT NULL, 
  PRIMARY KEY (`id_preso`,`id_advogado`),
  CONSTRAINT `FK_preso_has_advogado_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_preso_has_advogado_advogado` FOREIGN KEY (`id_advogado`) REFERENCES `advogado` (`registro_oab`) ON DELETE RESTRICT ON UPDATE CASCADE
);


