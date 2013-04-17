-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tempo de Geração: 
-- Versão do Servidor: 5.5.27
-- Versão do PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `genpen`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `advogado`
--

CREATE TABLE IF NOT EXISTS `advogado` (
  `registro_oab` int(10) NOT NULL,
  `uf_oab` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`registro_oab`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `almoxarifado`
--

CREATE TABLE IF NOT EXISTS `almoxarifado` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_penitenciaria` int(11) NOT NULL,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_almoxarifado_dados_funcionais` (`matricula_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `apoio_didatico`
--

CREATE TABLE IF NOT EXISTS `apoio_didatico` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_apoio_didatico_dados_funcionais` (`matricula_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `biometria`
--

CREATE TABLE IF NOT EXISTS `biometria` (
  `dedo_e1` varchar(512) DEFAULT NULL,
  `dedo_e2` varchar(512) DEFAULT NULL,
  `dedo_e3` varchar(512) DEFAULT NULL,
  `dedo_e4` varchar(512) DEFAULT NULL,
  `dedo_e5` varchar(512) DEFAULT NULL,
  `dedo_d1` varchar(512) DEFAULT NULL,
  `dedo_d2` varchar(512) DEFAULT NULL,
  `dedo_d3` varchar(512) DEFAULT NULL,
  `dedo_d4` varchar(512) DEFAULT NULL,
  `dedo_d5` varchar(512) DEFAULT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cela`
--

CREATE TABLE IF NOT EXISTS `cela` (
  `id` int(10) NOT NULL,
  `capacidade` int(3) NOT NULL,
  `cubagem` int(3) NOT NULL,
  `area` int(3) NOT NULL,
  `diametro` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cela_has_preso`
--

CREATE TABLE IF NOT EXISTS `cela_has_preso` (
  `id_cela` int(10) NOT NULL,
  `id_preso` int(10) NOT NULL,
  `data_entrada` date NOT NULL,
  PRIMARY KEY (`id_cela`,`id_preso`,`data_entrada`),
  KEY `FK_cela_has_preso_preso` (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `crime`
--

CREATE TABLE IF NOT EXISTS `crime` (
  `id` int(10) NOT NULL,
  `artigo` varchar(50) NOT NULL,
  `paragrafo` varchar(50) NOT NULL,
  `pena` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_funcionais`
--

CREATE TABLE IF NOT EXISTS `dados_funcionais` (
  `id_funcionario` int(10) NOT NULL,
  `matricula` int(10) NOT NULL,
  `cargo` varchar(30) NOT NULL,
  `data_ingresso` date NOT NULL,
  `data_saida` date NOT NULL,
  `situacao` varchar(15) NOT NULL,
  `horario_expediente` varchar(20) NOT NULL,
  `orgao_vinculado` int(7) NOT NULL,
  `setor` varchar(30) NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE KEY `matricula` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `endereco`
--

CREATE TABLE IF NOT EXISTS `endereco` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `rua` varchar(200) NOT NULL,
  `numero` varchar(6) NOT NULL,
  `complemento` varchar(100) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `cep` int(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `endereco`
--

INSERT INTO `endereco` (`id`, `rua`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `pais`, `cep`) VALUES
(1, 'leandro barreto', '355', '', 'toto', 'Recife', 'pe', 'brasil', 50791010);

-- --------------------------------------------------------

--
-- Estrutura da tabela `enfermaria`
--

CREATE TABLE IF NOT EXISTS `enfermaria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_enfermaria_dados_funcionais` (`matricula_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada_almoxarifado`
--

CREATE TABLE IF NOT EXISTS `entrada_almoxarifado` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_produto` int(10) NOT NULL,
  `id_almoxarifado` int(10) NOT NULL,
  `id_fornecedor` int(10) NOT NULL,
  `data_entrada` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_entrada_almoxarifado_produto` (`id_produto`),
  KEY `FK_entrada_almoxarifado_almoxarifado` (`id_almoxarifado`),
  KEY `FK_entrada_almoxarifado_fornecedor` (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada_apoio`
--

CREATE TABLE IF NOT EXISTS `entrada_apoio` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL,
  `id_apoio_didatico` int(10) NOT NULL,
  `tipo_apoio` varchar(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `matricula_instrutor` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_entrada_apoio_dados_funcionais` (`matricula_instrutor`),
  KEY `FK_entrada_apoio_preso` (`id_preso`),
  KEY `FK_entrada_apoio_apoio` (`id_apoio_didatico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada_enfermaria`
--

CREATE TABLE IF NOT EXISTS `entrada_enfermaria` (
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
  KEY `FK_entrada_enfermaria_dados_funcionais` (`matricula_medico`),
  KEY `FK_entrada_enfermaria_preso` (`id_preso`),
  KEY `FK_entrada_enfermaria_enfermaria` (`id_enfermaria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada_lavanderia`
--

CREATE TABLE IF NOT EXISTS `entrada_lavanderia` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `data_entrega` date NOT NULL,
  `data_saida` date NOT NULL,
  `responsavel_entrega` varchar(30) NOT NULL,
  `responsavel_saida` varchar(30) NOT NULL,
  `id_roupa` int(11) NOT NULL,
  `id_lavanderia` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_entrada_lavanderia_roupa` (`id_roupa`),
  KEY `FK_entrada_lavanderia_lavanderia` (`id_lavanderia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ficha_social`
--

CREATE TABLE IF NOT EXISTS `ficha_social` (
  `id_preso` int(10) NOT NULL AUTO_INCREMENT,
  `estado_civil` varchar(20) NOT NULL,
  `gestante` varchar(1) NOT NULL,
  `necessidades_especiais` varchar(20) NOT NULL,
  `grau_instrucao` varchar(20) NOT NULL,
  `religiao` varchar(20) NOT NULL,
  `profissao` varchar(20) NOT NULL,
  `outras_habilidades` varchar(20) NOT NULL,
  PRIMARY KEY (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE IF NOT EXISTS `fornecedor` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cnpj` int(11) NOT NULL,
  `telefone` int(11) NOT NULL,
  `endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario`
--

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cpf` int(10) NOT NULL,
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
  `endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `lavanderia`
--

CREATE TABLE IF NOT EXISTS `lavanderia` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `matricula_responsavel` int(10) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `localizacao` varchar(20) NOT NULL,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lavanderia_dados_funcionais` (`matricula_responsavel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `parente`
--

CREATE TABLE IF NOT EXISTS `parente` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `data_nascimento` date NOT NULL,
  `tipo_parentesco` varchar(15) NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_parente_preso` (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pena`
--

CREATE TABLE IF NOT EXISTS `pena` (
  `id_preso` int(10) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date DEFAULT NULL,
  PRIMARY KEY (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `penitenciaria`
--

CREATE TABLE IF NOT EXISTS `penitenciaria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `orgao` varchar(50) NOT NULL,
  `sigla` varchar(50) NOT NULL,
  `cnpj` int(14) NOT NULL,
  `responsavel` varchar(50) NOT NULL,
  `seguranca` varchar(30) NOT NULL,
  `telefone` int(11) NOT NULL,
  `endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `preso`
--

CREATE TABLE IF NOT EXISTS `preso` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sexo` varchar(10) NOT NULL,
  `cor_pele` varchar(10) NOT NULL,
  `tipo_sanguineo` varchar(7) DEFAULT NULL,
  `nacionalidade` varchar(20) NOT NULL,
  `data_nascimento` date NOT NULL,
  `observacoes` varchar(50) DEFAULT NULL,
  `endereco` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `preso_has_advogado`
--

CREATE TABLE IF NOT EXISTS `preso_has_advogado` (
  `id_preso` int(10) NOT NULL,
  `id_advogado` int(10) NOT NULL,
  PRIMARY KEY (`id_preso`,`id_advogado`),
  KEY `FK_preso_has_advogado_advogado` (`id_advogado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE IF NOT EXISTS `produto` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(11) NOT NULL,
  `quantidade` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `prontuario`
--

CREATE TABLE IF NOT EXISTS `prontuario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `alcunha` varchar(50) NOT NULL,
  `regime` varchar(50) NOT NULL,
  `foto_perfil` blob NOT NULL,
  `foto_frente` blob NOT NULL,
  `id_preso` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_prontuario_preso` (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `prontuario_has_crime`
--

CREATE TABLE IF NOT EXISTS `prontuario_has_crime` (
  `id_prontuario` int(10) NOT NULL,
  `id_crime` int(10) NOT NULL,
  PRIMARY KEY (`id_prontuario`,`id_crime`),
  KEY `FK_prontuario_has_crime_crime` (`id_crime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `roupa`
--

CREATE TABLE IF NOT EXISTS `roupa` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL,
  `descricao` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_roupa_preso` (`id_preso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `visita`
--

CREATE TABLE IF NOT EXISTS `visita` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_preso` int(10) NOT NULL,
  `data` date NOT NULL,
  `duracao` time NOT NULL,
  `id_parente` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_visita_preso` (`id_preso`),
  KEY `FK_visita_parente` (`id_parente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `almoxarifado`
--
ALTER TABLE `almoxarifado`
  ADD CONSTRAINT `FK_almoxarifado_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `apoio_didatico`
--
ALTER TABLE `apoio_didatico`
  ADD CONSTRAINT `FK_apoio_didatico_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `biometria`
--
ALTER TABLE `biometria`
  ADD CONSTRAINT `FK_biometria_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `cela_has_preso`
--
ALTER TABLE `cela_has_preso`
  ADD CONSTRAINT `FK_cela_has_preso_cela` FOREIGN KEY (`id_cela`) REFERENCES `cela` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_cela_has_preso_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `dados_funcionais`
--
ALTER TABLE `dados_funcionais`
  ADD CONSTRAINT `FK_dados_funcionais_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `enfermaria`
--
ALTER TABLE `enfermaria`
  ADD CONSTRAINT `FK_enfermaria_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `entrada_almoxarifado`
--
ALTER TABLE `entrada_almoxarifado`
  ADD CONSTRAINT `FK_entrada_almoxarifado_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_almoxarifado_almoxarifado` FOREIGN KEY (`id_almoxarifado`) REFERENCES `almoxarifado` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_almoxarifado_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `entrada_apoio`
--
ALTER TABLE `entrada_apoio`
  ADD CONSTRAINT `FK_entrada_apoio_dados_funcionais` FOREIGN KEY (`matricula_instrutor`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_apoio_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_apoio_apoio` FOREIGN KEY (`id_apoio_didatico`) REFERENCES `apoio_didatico` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `entrada_enfermaria`
--
ALTER TABLE `entrada_enfermaria`
  ADD CONSTRAINT `FK_entrada_enfermaria_dados_funcionais` FOREIGN KEY (`matricula_medico`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_enfermaria_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_enfermaria_enfermaria` FOREIGN KEY (`id_enfermaria`) REFERENCES `enfermaria` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `entrada_lavanderia`
--
ALTER TABLE `entrada_lavanderia`
  ADD CONSTRAINT `FK_entrada_lavanderia_roupa` FOREIGN KEY (`id_roupa`) REFERENCES `roupa` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_entrada_lavanderia_lavanderia` FOREIGN KEY (`id_lavanderia`) REFERENCES `lavanderia` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `ficha_social`
--
ALTER TABLE `ficha_social`
  ADD CONSTRAINT `FK_ficha_social_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `lavanderia`
--
ALTER TABLE `lavanderia`
  ADD CONSTRAINT `FK_lavanderia_dados_funcionais` FOREIGN KEY (`matricula_responsavel`) REFERENCES `dados_funcionais` (`matricula`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `parente`
--
ALTER TABLE `parente`
  ADD CONSTRAINT `FK_parente_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `pena`
--
ALTER TABLE `pena`
  ADD CONSTRAINT `FK_pena_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `preso_has_advogado`
--
ALTER TABLE `preso_has_advogado`
  ADD CONSTRAINT `FK_preso_has_advogado_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_preso_has_advogado_advogado` FOREIGN KEY (`id_advogado`) REFERENCES `advogado` (`registro_oab`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `prontuario`
--
ALTER TABLE `prontuario`
  ADD CONSTRAINT `FK_prontuario_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `prontuario_has_crime`
--
ALTER TABLE `prontuario_has_crime`
  ADD CONSTRAINT `FK_prontuario_has_crime_prontuario` FOREIGN KEY (`id_prontuario`) REFERENCES `prontuario` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prontuario_has_crime_crime` FOREIGN KEY (`id_crime`) REFERENCES `crime` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `roupa`
--
ALTER TABLE `roupa`
  ADD CONSTRAINT `FK_roupa_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE;

--
-- Restrições para a tabela `visita`
--
ALTER TABLE `visita`
  ADD CONSTRAINT `FK_visita_preso` FOREIGN KEY (`id_preso`) REFERENCES `preso` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_visita_parente` FOREIGN KEY (`id_parente`) REFERENCES `parente` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
