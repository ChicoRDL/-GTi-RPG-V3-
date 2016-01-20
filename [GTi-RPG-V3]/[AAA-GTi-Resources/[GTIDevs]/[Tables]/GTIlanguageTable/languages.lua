    -- -------------------------------------->>
    -- GTI: Grand Theft International
    -- Date: 06/04/2015
    -- Resource: GTIlanguageTable/languages.lua
    -- Type: Server Side
    -- Author: Jack Johnson (Jack)
    ----------------------------------------->>
     
    local languages = {}
     
    --Credits to Callum Dawson for the idea.
    languages["server"] = {
            PLAYER_LOGGEDIN = {
                    en_US = "* %s has logged in.",
                    fr = "* %s a connecté.",
                    es = "* %s se ha conectado.",
                    pt_BR = "%s conectou-se."
            },
            PLAYER_QUIT = {
                    en_US = "* %s has left the game [%s]",
                    fr = "* a quitté la partie [%s]",
                    es = "* %s ha abandonado el juego [%s]",
                    pt_BR = "* %s desconectou-se [%s]"
            },
            PLAYER_NICK_CHANGE = {
                    en_US = "* %s is now known as %s",
                    fr = "* %s est maintenant connu comme %s",
                    es = "* %s es ahora conocido como %s",
                    pt_BR = "* %s e agora conhecido como %s"
            },
            PLAYER_FIRST_JOIN = {
                    en_US = "* %s has joined for the first time. Say hello, guys!",
                    fr = "* %s a rejoint pour la première fois. Dites bonjour, les gars!",
                    es = "* %s ha entrado por primera vez. ¡Denle la bienvenida!",
                    pt_BR = "* %s conectou-se pela primeira vez. Digam Ola, pessoal!"
            },
            ALLOW_SCREENSHOT_KICK = {
                    en_US = "Enable 'Allow screen upload' in Esc > Settings",
                    es = "Habilita 'Permitir subir capturas de pantalla' en las configuraciones (Escape > Configuraciones)",
                    pt_BR = "Ativa a opcao 'Permitir o envio de capturas de tela' pressionando ESC>Opcoes",
            }
    }
     
    languages["client"] = {
            --Login window
            ACCOUNTS_LOGIN_PLAY = {
                    en_US = "PLAY!",
                    fr = "JOUER!",
                    es = "JUGAR!",
                    pt_BR = "JOGAR!"
            },
            ACCOUNTS_LOGIN_REGISTER = {
                    en_US = "Register",
                    fr = "Se enregistrer",
                    es = "Registrarse",
                    pt_BR = "Registe-se"
                   
            },
            ACCOUNTS_LOGIN_LEAVE = {
                    en_US = "Leave",
                    fr = "Laisser",
                    es = "Salir",
                    pt_BR = "Sair"
            },
            ACCOUNTS_LOGIN_RECOVER = {
                    en_US = "Recover",
                    fr = "Récupérer",
                    es = "Recuperar",
                    pt_BR = "Recuperar"     
            },
           
            --Register window
            ACCOUNTS_REGISTER_TITLE = {
                    en_US = "GTI Account Registration",
                    es = "GTI Registro de Cuenta",
                    pt_BR = "Registo de Conta do GTI"
            },
            ACCOUNTS_REGISTER_USERNAME = {
                    en_US = "Enter a username:",
                    es = "Nombre de usuario:",
                    pt_BR = "Nome de utilizador:"
            },
            ACCOUNTS_REGISTER_EMAIL = {
                    en_US = "E-mail Address (Optional):",
                    es = "E-mail (Opcional):",
                    pt_BR = "Endereco de E-mail (Opcional):"
            },
            ACCOUNTS_REGISTER_PASSWORD = {
                    en_US = "Enter a Password",
                    es = "Ingresa una contrasena",
                    pt_BR = "Insira uma palavra-passe"
            },
            ACCOUNTS_REGISTER_REPEAT = {
                    en_US = "Repeat Password",
                    es = "Repite la contrasena",
                    pt_BR = "Repita a palavra-passe"
            },
            ACCOUNTS_REGISTER_TEXT = {
                    en_US = "Your account Username is the username that you will login with. It cannot be changed. Your e-mail address will be used to recover your password in the event that you forget it. It is completely optional, but password recovery will be a lot more difficult without it. Your password can be changed in the future.",
		    es = "Tu nombre de cuenta sera utilizado para la autenticacion. El nombre de cuenta no puede ser cambiado. Tu e-mail sera usado para recuperar tu contrasena en caso de que la olvides. Esto es completamente opcional, pero la recuperacion de tu contrasena sera mas dificil sin esto. Tu contrasena puede ser cambiada en el futuro",
                    pt_BR = "O Nome de Utilizador sera usado para realizares a autenticacao. O nome de utilizador nao pode ser alterado. O teu endereco de e-mail sera usado para recuperar a tua palavra-passe no caso de te esqueceres dela. E completamente opcional, mas a recuperacao de palavra-passe sera muito mais dificil sem ele. A tua palavra-passe pode ser alterada no futuro."
            },
            ACCOUNTS_REGISTER_REGISTER = {
                    en_US = "Register",
                    es = "Registar",
                    pt_BR = "Registar"
            },
            ACCOUNTS_REGISTER_CLOSE = {
                    en_US = "Close",
                    es = "Cerrar",
                    pt_BR = "Fechar"
            },
           
            --Recovery window
            ACCOUNTS_RECOVERY_TITLE = {
                    en_US = "GTI Account Recovery",
                    es = "GTI Recuperacion de cuenta",
                    pt_BR = "Recuperacao de conta GTI"
            },
            ACCOUNTS_RECOVERY_USERNAME = {
                    en_US = "Enter Username:",
                    es = "Ingresa nombre de usuario:",
                    pt_BR = "Introduza Nome de utilizador"
            },
            ACCOUNTS_RECOVERY_EMAIL = {
                    en_US = "Enter Email Address:",
                    es = "Introduzca un e-mail:",
                    pt_BR = "Introduza Endereco de E-mail:"
            },
            ACCOUNTS_RECOVERY_RECOVER = {
                    en_US = "Recover",
                    es = "Recuperar",
                    pt_BR = "Recuperar"
            },
            ACCOUNTS_RECOVERY_CANCEL = {
                    en_US = "Cancel",
                    es = "Cancelar",
                    pt_BR = "Cancelar"
            },
     
            USEFUL_MESSAGES_1 = {
                    en_US = "Get involved in our democratic community | Visit gtirpg.net",
                    pt_BR = "Envolve-te na nossa comunidade democratica | Visita gtirpg.net",
                    es = "Introducete en nuestra democratica comunidad | Visita gtirpg.net"
            },
            USEFUL_MESSAGES_2 = {
                    en_US = "Become a Police Officer at any major police department.",
                    pt_BR = "Torna-te Policia num dos departamentos de Policia.",
                    es = "Conviertete en Oficial de Policia en cualquier departamento de policia."
            },
            USEFUL_MESSAGES_3 = {
                    en_US = "Visit Ammu-Nation for a free Pistol!",
                    pt_BR = "Visita uma Ammu-Nation para receberes uma pistola gratuita!",
                    es = "Visita los Ammu-Nations para obtener una pistola gratis!"
            },
            USEFUL_MESSAGES_4 = {
                    en_US = "Need some cash? Visit the bank! All new accounts get some money to start out with.",
                    pt_BR = "Precisas de dinheiro? Visita o banco! Todas as novas contas sao criadas com algum dinheiro.",
                    es = "¿Necesitas dinero? ¡Visita el banco! Todas las nuevas cuentas comienzan con una cantidad de dinero."
            },
            USEFUL_MESSAGES_5 = {
                    en_US = "Like what you see? Spread the word! Tell your friends about GTI.",
                    pt_BR = "Gostas do que ves? Espalha a palavra! Fala do GTI aos teus amigos.",
                    es = "¿Te gusta lo que ves? ¡Propaga la palabra! Dile a tus amigos sobre GTI."
            },
            USEFUL_MESSAGES_6 = {
                    en_US = "GTI is being updated every day! Use /updates or visit gtirpg.net/updates.php to stay informed on progress.",
                    pt_BR = "O GTI esta a ser atualizado todos os dias! Usa /updates ou visita gtirpg.net/updates.php para ficar informado do nosso progresso.",
                    es = "¡GTI es actualizado cada día! Usa /updates o visita gtirpg.net/updates.php para permanecer informado"
            },
            USEFUL_MESSAGES_7 = {
                    en_US = "You can buy a car at one of our car dealerships spread around San Andreas.",
                    pt_BR = "Podes comprar um carro num dos nossos concessionarios de veiculos espalhados por San Andreas.",
                    es = "Puedes comprar un vehiculo en cualquiera de nuestros concesionarios alrededor San Andreas."
            },
            USEFUL_MESSAGES_8 = {
                    en_US = "Press B to use the GTIdroid. The GTIdroid contains many features that you should explore.",
                    pt_BR = "Pressiona B para usar o GTIdroid. O GTIdroid contem varias ferramentas que deves explorar.",
                    es = "Presiona B para usar el GTIdroid. El GTIdroid contiene muchas herramientas que deberias explorar."
            },
            USEFUL_MESSAGES_9 = {
                    en_US = "Buy a new skin at one of our clothing stores.",
                    pt_BR = "Compra uma nova skin numa das nossas lojas de roupa.",
                    es = "Compra un nuevo skin en una de nuestras tiendas de ropa."
            },
            USEFUL_MESSAGES_10 = {
                    en_US = "Earn quick cash in one of our CnR event robberies. Use /cnrtime to see when the next one is.",
                    pt_BR = "Ganha dinheiro rapido num dos nossos eventos CnR. Usa /cnrtime para ver qual e quando e o proximo.",
                    es = "Gana dinero rapidamente en uno de nuestros eventos CnR. Usa /cnrtime para ver cuando es el proximo."
            },
            USEFUL_MESSAGES_11 = {
                    en_US = "Most server information can be found by pressing F9",
                    pt_BR = "A maior parte da informacao do servidor pode ser encontrada pressionando F9",
                    es = "Mas informacion del servidor puede ser encontrada presionando F9"
            },
            USEFUL_MESSAGES_12 = {
                    en_US = "Forum: gtirpg.net | IRC: irc.gtirpg.net | TS3: ts3.gtirpg.net",
                    pt_BR = "Forum: gtirpg.net | IRC: irc.gtirpg.net | TS3: ts3.gtirpg.net",
                    es = "Foro: gtirpg.net | IRC: irc.gtirpg.net | TS3: ts3.gtirpg.net"
            },
            USEFUL_MESSAGES_13 = {
                    en_US = "Donate to help keep this server alive and kicking! Go to gtirpg.net/donate",
                    pt_BR = "Doa para manter o servidor a funcionar! Visita gtirpg.net/donate",
                    es = "¡Dona para mantener el servidor vivo y coleando! Ve a gtirpg.net/donate"
            },
			USEFUL_MESSAGES_14 = {
                    en_US = "You can complete stunts and earn different rewards! use /markstunts for their locations.",
                    --pt_BR = "Você pode criar itens como munição, kits de médico, pára-quedas e muito mais, pressione F10 para o nosso sistema de crafting!",
                   -- es = "Puedes crear items como munición medic kits, paracaidas y más, presiona F10 para nuestro sistema de craft"
            },
			USEFUL_MESSAGES_15 = {
                    en_US = "You can craft items such as ammo, medic kits, parachutes and more, press F10 for our crafting system!",
                    pt_BR = "Você pode criar itens como munição, kits de médico, pára-quedas e muito mais, pressione F10 para o nosso sistema de crafting!",
                    es = "Puedes crear items como munición medic kits, paracaidas y más, presiona F10 para nuestro sistema de craft"
            }
    }
     
    function getLanguages()
            return languages or {}
    end
