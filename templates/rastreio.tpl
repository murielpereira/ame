<div id="rastreio-container-custom">
    <style>
        /* --- ESTILO DO CONTAINER (Substitui o body) --- */
        #rastreio-container-custom {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0f0518;
            color: #ffffff;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            min-height: 600px; /* Garante que ocupa espaço na tela */
            box-sizing: border-box;
        }

        /* --- BARRA DE PESQUISA --- */
        .campo_pesquisar {
            background: #1e1e2f;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            max-width: 100%;
        }
        #rastreio-container-custom input[type="text"] {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #333;
            background: #2b2b40;
            color: white;
            width: 250px;
        }
        #rastreio-container-custom input[type="button"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background: #007bff;
            color: white;
            cursor: pointer;
            font-weight: bold;
        }
        #rastreio-container-custom input[type="button"]:hover { background: #0056b3; }

        /* --- GRID LAYOUT --- */
        #resultado {
            width: 100%;
            max-width: 950px;
            display: none;
            gap: 20px;
            grid-template-columns: 1.8fr 1fr; 
        }
        @media (max-width: 850px) {
            #resultado { grid-template-columns: 1fr; }
        }

        /* --- CARDS --- */
        .card {
            background-color: #0d0d0d;
            border: 1px solid #2a2a2a;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }
        
        /* Botão de Ajuda (WhatsApp) */
        .card-ajuda {
            border: 1px solid #ff7b00;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }
        .card-ajuda:hover {
            background-color: rgba(255, 123, 0, 0.1);
        }

        /* Link Discreto */
        .link-discreto {
            display: block;
            text-align: center;
            margin-top: 5px;
            margin-bottom: 20px;
            color: #555;
            font-size: 0.85em;
            text-decoration: none;
            transition: color 0.3s;
        }
        .link-discreto:hover {
            color: #888;
            text-decoration: underline;
        }

        /* --- HEADER DO PEDIDO & COPIAR --- */
        .pedido-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 30px; border-bottom: 1px solid #333; padding-bottom: 20px;
        }
        /* Área clicável para copiar */
        .codigo-copiavel {
            font-size: 1.5em; 
            font-weight: bold; 
            display: flex; 
            align-items: center; 
            gap: 10px;
            cursor: pointer;
            transition: color 0.2s;
            position: relative;
        }
        .codigo-copiavel:hover {
            color: #00ff88;
        }
        .codigo-copiavel:active {
            transform: scale(0.98);
        }
        .icone-copiar {
            opacity: 0;
            transition: opacity 0.2s;
            fill: #00ff88;
            width: 20px;
            height: 20px;
        }
        .codigo-copiavel:hover .icone-copiar {
            opacity: 1;
        }

        .badge-rastreio {
            background: #333; color: #aaa; font-size: 0.6em; 
            padding: 5px 10px; border-radius: 20px; letter-spacing: 1px;
        }

        /* --- NOTIFICAÇÃO TOAST --- */
        #toast {
            visibility: hidden;
            min-width: 250px;
            background-color: #333;
            color: #00ff88;
            text-align: center;
            border-radius: 50px;
            padding: 16px;
            position: fixed;
            z-index: 1000;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
            border: 1px solid #00ff88;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            font-size: 16px;
            opacity: 0;
            transition: opacity 0.3s, bottom 0.3s;
        }
        #toast.mostrar {
            visibility: visible;
            opacity: 1;
            bottom: 50px;
        }

        /* --- PROGRESS BAR --- */
        .progress-container {
            display: flex; justify-content: space-between; position: relative;
            margin-bottom: 40px; margin-top: 10px; padding: 0 20px;
        }
        .progress-line-bg {
            position: absolute; top: 15px; left: 30px; right: 30px;
            height: 3px; background: #333; z-index: 0;
        }
        .progress-line-fill {
            position: absolute; top: 15px; left: 30px;
            height: 3px; background: #00ff88; z-index: 1;
            width: 0%; transition: width 1s ease;
        }
        .progress-step {
            position: relative; z-index: 2; text-align: center;
            display: flex; flex-direction: column; align-items: center;
        }
        .step-circle {
            width: 30px; height: 30px; background: #0d0d0d;
            border: 2px solid #555; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 10px; transition: all 0.5s;
        }
        .step-label { font-size: 0.85em; color: #888; font-weight: 500; }
        .progress-step.active .step-circle { border-color: #00ff88; background: #00ff88; color: #000; box-shadow: 0 0 15px rgba(0,255,136,0.4); }
        .progress-step.active .step-label { color: #fff; }
        .progress-step.active .step-circle svg { fill: #000; }
        .step-circle svg { width: 16px; height: 16px; fill: #555; }

        /* --- TIMELINE VERTICAL --- */
        .timeline { position: relative; margin-top: 20px; padding-left: 10px; }
        .timeline-item {
            position: relative; padding-left: 45px; padding-bottom: 40px;
            border-left: 2px solid #333;
        }
        .timeline-item:last-child { border-left: none; }
        .timeline-icon-box {
            position: absolute; left: -16px; top: 0; width: 32px; height: 32px;
            background-color: #2a2a2a; border-radius: 50%; border: 4px solid #0d0d0d;
            display: flex; align-items: center; justify-content: center; z-index: 2;
        }
        .timeline-item.entregue .timeline-icon-box { background-color: #00ff88; color: #000; }
        .timeline-item.transito .timeline-icon-box { background-color: #007bff; color: #fff; }
        .timeline-item.pendente .timeline-icon-box { background-color: #ffc107; color: #000; }
        .timeline-item.padrao .timeline-icon-box { background-color: #555; color: #fff; }
        .timeline-icon-box svg { width: 16px; height: 16px; fill: currentColor; }
        
        .status-titulo { font-weight: bold; font-size: 1.1em; color: #fff; margin-bottom: 4px; }
        .status-desc { color: #bbb; font-size: 0.95em; margin-bottom: 4px; }
        .status-data { color: #666; font-size: 0.85em; }

        /* --- COLUNA DIREITA --- */
        .card-header { font-size: 0.8em; color: #888; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .card-value { font-size: 1.1em; font-weight: bold; color: #fff; }
        .transportadora-info { display: flex; align-items: center; gap: 15px; }
        .logo-img { width: 60px; height: 60px; object-fit: contain; background: #fff; border-radius: 8px; padding: 5px; }
        .coluna-direita { display: flex; flex-direction: column; }
    </style>

    <div id="toast">Código copiado com sucesso!</div>

    <div class="campo_pesquisar">
        <input type="text" id="codigo" placeholder="Digite o código (Ex: SM...)" value="">
        <input type="button" id="botao_pesquisar" value="RASTREAR" onclick="pesquisar()">
    </div>

    <div id="resultado"></div>

    <script>
        // --- UTILITÁRIOS ---
        const icons = {
            check: `<svg viewBox="0 0 24 24"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>`,
            truck: `<svg viewBox="0 0 24 24"><path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.66 1.34 3 3 3s3-1.34 3-3h6c0 1.66 1.34 3 3 3s3-1.34 3-3h2v-5l-3-4zM6 18.5c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5zm13.5-9l1.96 2.5H17V9.5h2.5zm-1.5 9c-.83 0-1.5-.67-1.5-1.5s.67-1.5 1.5-1.5 1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"/></svg>`,
            box: `<svg viewBox="0 0 24 24"><path d="M20 6h-4V4c0-1.11-.89-2-2-2h-4c-1.11 0-2 .89-2 2v2H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zm-6 0h-4V4h4v2z"/></svg>`,
            dot: `<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="8"/></svg>`,
            help: `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ff7b00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>`,
            copy: `<svg viewBox="0 0 24 24"><path d="M16 1H4c-1.1 0-2 .9-2 2v14h2V3h12V1zm3 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 16H8V7h11v14z"/></svg>`
        };

        function obterLogo(nomeServico) {
            if (!nomeServico) return 'https://cdn-icons-png.flaticon.com/512/713/713311.png';
            const nome = nomeServico.toLowerCase();
            if (nome.includes('loggi')) return 'https://logodownload.org/wp-content/uploads/2019/07/loggi-logo-0.png';
            if (nome.includes('pac')) return 'https://logodownload.org/wp-content/uploads/2017/03/pac-correios-logo-1.png';
            if (nome.includes('sedex')) return 'https://logodownload.org/wp-content/uploads/2017/03/sedex-logo-1.png';
            if (nome.includes('total')) return 'https://logodownload.org/wp-content/uploads/2019/09/total-express-logo-0.png';
            if (nome.includes('j&t')) return 'https://images.seeklogo.com/logo-png/33/1/jt-express-logo-png_seeklogo-336498.png';
            if (nome.includes('jadlog')) return 'https://logodownload.org/wp-content/uploads/2019/02/jadlog-logo-0.png';
            return 'https://cdn-icons-png.flaticon.com/512/713/713311.png';
        }

        function obterIcone(tipo) {
            if (tipo === 'DELIVERED') return { svg: icons.check, classe: 'entregue' };
            if (tipo === 'IN TRANSIT') return { svg: icons.truck, classe: 'transito' };
            if (tipo === 'POSTED') return { svg: icons.box, classe: 'pendente' };
            return { svg: icons.dot, classe: 'padrao' };
        }

        // --- FUNÇÃO PARA COPIAR CÓDIGO ---
        function copiarCodigo(texto) {
            navigator.clipboard.writeText(texto).then(() => {
                // Mostra o Toast
                const toast = document.getElementById("toast");
                toast.className = "mostrar";
                
                // Esconde depois de 3 segundos
                setTimeout(function(){ 
                    toast.className = toast.className.replace("mostrar", ""); 
                }, 3000);
            }).catch(err => {
                console.error('Erro ao copiar: ', err);
            });
        }

        async function pesquisar() {
            const inputCodigo = document.getElementById('codigo');
            const codigo = inputCodigo.value;
            const divResultado = document.getElementById('resultado');

            if (!codigo) { alert("Digite o código!"); return; }
            inputCodigo.value = ""; 

            divResultado.style.display = "block";
            divResultado.innerHTML = "<p style='width:100%; text-align:center'>A carregar dados...</p>";

            const proxy = "https://cors-anywhere.herokuapp.com/"; 
            const api_url = "https://api.smartenvios.com/v1/freight-order/tracking";
            const token = "NY2WulkhIl8n4Ttbqjj25zhmdyvikro"; 

            try {
                const resposta = await fetch(proxy + api_url, {
                    method: "POST",
                    headers: { "Content-Type": "application/json", "Accept": "application/json", "token": token },
                    body: JSON.stringify({ "tracking_code": codigo })
                });

                if (!resposta.ok) throw new Error("Erro na conexão");
                const json = await resposta.json();
                const r = json.result;
                if (!r) { divResultado.innerHTML = "<p>Código não encontrado.</p>"; return; }

                // --- PROCESSAMENTO ---
                const eventos = (r.trackings || []).reverse();
                
                let progresso = 0; 
                let statusEntregue = false;
                if (eventos.length > 0) progresso = 33; 
                const ultimoEvento = eventos[0];
                if (ultimoEvento && ultimoEvento.code.tracking_type === 'DELIVERED') {
                    progresso = 100;
                    statusEntregue = true;
                } else if (eventos.length > 1) {
                    progresso = 66; 
                }

                let textoPrevisao = "Sob Consulta";
                let estiloPrevisao = "color: #888;";
                if (r.delivery_prevision) {
                    textoPrevisao = new Date(r.delivery_prevision).toLocaleDateString('pt-BR');
                    estiloPrevisao = "color: #ffc107;";
                }

                // --- MONTAGEM DA TIMELINE ---
                let timelineHTML = '';
                eventos.forEach((ev) => {
                    const data = new Date(ev.date).toLocaleString('pt-BR');
                    const infoIcone = obterIcone(ev.code.tracking_type);
                    timelineHTML += `
                        <div class="timeline-item ${infoIcone.classe}">
                            <div class="timeline-icon-box">${infoIcone.svg}</div>
                            <div class="status-titulo">${ev.code.name}</div>
                            <div class="status-desc">${ev.observation || ''}</div>
                            <div class="status-data">${data}</div>
                        </div>
                    `;
                });

                // --- RENDERIZAÇÃO FINAL ---
                divResultado.style.display = "grid";
                divResultado.innerHTML = `
                    <div class="card">
                        <div class="pedido-header">
                            <div class="codigo-copiavel" onclick="copiarCodigo('${r.tracking_code}')" title="Clique para copiar">
                                <div><svg width="24" height="24" viewBox="0 0 24 24" fill="#fff"><path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.66 1.34 3 3 3s3-1.34 3-3h6c0 1.66 1.34 3 3 3s3-1.34 3-3h2v-5l-3-4z"/></svg></div>
                                <span>${r.tracking_code}</span>
                                <div class="icone-copiar">${icons.copy}</div> </div>
                            <span class="badge-rastreio">RASTREIO</span>
                        </div>

                        <div class="progress-container">
                            <div class="progress-line-bg"></div>
                            <div class="progress-line-fill" style="width: ${statusEntregue ? '100%' : (progresso === 66 ? '50%' : '0%')}"></div>
                            <div class="progress-step ${progresso >= 33 ? 'active' : ''}">
                                <div class="step-circle">${icons.box}</div>
                                <div class="step-label">Postado</div>
                            </div>
                            <div class="progress-step ${progresso >= 66 ? 'active' : ''}">
                                <div class="step-circle">${icons.truck}</div>
                                <div class="step-label">Em rota</div>
                            </div>
                            <div class="progress-step ${progresso === 100 ? 'active' : ''}">
                                <div class="step-circle">${icons.check}</div>
                                <div class="step-label">Entregue</div>
                            </div>
                        </div>
                        
                        <div class="timeline">
                            ${timelineHTML}
                        </div>
                    </div>

                    <div class="coluna-direita">
                        
                        <div class="card" style="display:flex; gap:15px; align-items:center;">
                             <div style="background:#1a1a1a; padding:10px; border-radius:10px; border:1px solid #333">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="#ff7b00"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
                             </div>
                             <div>
                                <div class="card-header">Destinatário</div>
                                <div class="card-value">${r.destiny_name}</div>
                                <div style="color: #aaa; margin-top:5px; font-size:0.9em">
                                    ${r.destiny_city_name || ''} - ${r.destiny_uf || ''}
                                </div>
                             </div>
                        </div>

                        <div class="card">
                            <div class="card-header">Transportadora</div>
                            <div class="transportadora-info" style="margin-bottom: 20px;">
                                <img src="${obterLogo(r.service_name)}" class="logo-img">
                                <div>
                                    <div class="card-value">${r.service_name}</div>
                                </div>
                            </div>

                            <div class="card-header">Previsão de Entrega</div>
                            <div class="card-value" style="${estiloPrevisao}">
                                ${textoPrevisao}
                            </div>
                        </div>

                        <a href="https://wa.me/5548991574943" target="_blank" rel="noopener noreferrer" class="card card-ajuda">
                            ${icons.help}
                            <span style="color: #ff7b00; font-weight: bold;">Precisa de ajuda? Fale conosco</span>
                        </a>

                        <a href="https://portal.smartenvios.com/rastreamento/codigo-de-rastreio/${r.tracking_code}" target="_blank" rel="noopener noreferrer" class="link-discreto">
                            + Ver detalhes completos no site oficial
                        </a>

                    </div>
                `;

            } catch (erro) {
                console.error(erro);
                divResultado.innerHTML = '';
                const erroP = document.createElement('p');
                erroP.style.color = 'red';
                erroP.style.textAlign = 'center';
                erroP.textContent = `Erro: ${erro.message}`;
                divResultado.appendChild(erroP);
            }
        }
    </script>
</div>