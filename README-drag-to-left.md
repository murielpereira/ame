# Ícone Drag to Left - Documentação

## Descrição
Este é um ícone animado que simula um dedo pressionando e deslizando para a esquerda, indicando ao usuário que o conteúdo pode ser arrastado nessa direção.

## Características

### Animação
- **Duração**: 2.5 segundos
- **Easing**: `cubic-bezier(0.4, 0, 0.2, 1)` para movimento suave
- **Efeitos**:
  - Escala (scale) para simular pressão
  - Rotação sutil para movimento natural
  - Opacidade variável para efeito de desvanecimento
  - Movimento horizontal progressivo

### Design
- **Tamanho**: 64x64px
- **Cores**: 
  - Dedo: Azul (#6C63FF)
  - Seta: Vermelho (#FF6B6B)
  - Unha: Branco (#FFFFFF)
- **Efeitos visuais**:
  - Sombra suave
  - Drop-shadow no SVG
  - Efeito de brilho

## Como usar

### 1. HTML Básico
```html
<div class="drag-to-left-icon">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
        <!-- Conteúdo do SVG aqui -->
    </svg>
</div>
```

### 2. CSS (já incluído no style-critical.scss)
```css
.drag-to-left-icon {
    position: absolute;
    bottom: 50px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 100;
    width: 64px;
    height: 64px;
    animation: drag-to-left 2.5s cubic-bezier(0.4, 0, 0.2, 1) infinite;
    cursor: pointer;
}
```

### 3. Posicionamento
O ícone é posicionado absolutamente na parte inferior da tela. Para ajustar:

```css
.drag-to-left-icon {
    bottom: 50px; /* Distância do fundo */
    left: 50%;    /* Centralizado horizontalmente */
}
```

## Arquivos disponíveis

1. **style-critical.scss** - CSS principal com animação
2. **drag-to-left-icon.svg** - Versão detalhada do ícone
3. **drag-to-left-simple.svg** - Versão simplificada
4. **drag-to-left-example.html** - Exemplo de uso
5. **README-drag-to-left.md** - Esta documentação

## Personalização

### Mudar cores
```css
.drag-to-left-icon svg path[fill="#6C63FF"] {
    fill: #sua-cor-aqui;
}
```

### Ajustar velocidade
```css
.drag-to-left-icon {
    animation-duration: 3s; /* Mais lento */
    /* ou */
    animation-duration: 1.5s; /* Mais rápido */
}
```

### Desabilitar animação
```css
.drag-to-left-icon {
    animation: none;
}
```

## Compatibilidade
- ✅ Chrome/Edge (WebKit)
- ✅ Firefox
- ✅ Safari
- ✅ Mobile browsers

## Performance
- Usa `transform` e `opacity` para animações suaves
- SVG otimizado para carregamento rápido
- Animações CSS nativas para melhor performance

## Casos de uso
- Indicar swipe horizontal em carrosséis
- Mostrar navegação lateral
- Guiar usuários em interfaces touch
- Indicar scroll horizontal 