package oldsgame;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;
import java.awt.Font;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

import alice.tuprolog.*;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

public class Interface implements ActionListener {

    private boolean player2 = false;
    private Prolog engine = new Prolog();
    private List<String> lista = new ArrayList();
    private List<String> a = new ArrayList();
    private JPanel panel;

    public Interface() {
        criarTela();
        a.add("x");
        a.add("o");
    }

    private void criarTela() {
        JFrame janela = new JFrame("Primeiro o jogo da velha, depois o mundo");
        panel = new JPanel(new GridLayout(3, 3));
        janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        janela.add(panel);
        for (int i = 1; i < 10; i++) {
            JButton botao = new JButton();
            botao.addActionListener(this);
            botao.setName(i + "");
            botao.setFont(new Font("Arial", Font.BOLD, 40));
            botao.setBackground(Color.white);
            panel.add(botao);
            lista.add("a");
        }
        janela.setSize(450, 450);
        janela.setVisible(true);
    }

    private void desenhar(JButton b) {
        if (player2 && b.getText() == "") {
            b.setText("O");
            player2 = !player2;
        } else if (b.getText() == "") {
            b.setText("X");
            player2 = !player2;
        }
    }

    @Override
    public void actionPerformed(ActionEvent event) {
        if (lista.contains("a")) {
            Object o = event.getSource();
            JButton b = (JButton) o;
            desenhar(b);
            int p = Integer.parseInt(b.getName());
            lista.set(p - 1, "x");
            try {
                Theory theory = new Theory(new FileInputStream("velha.pl"));
                engine.setTheory(theory);
                SolveInfo info = engine.solve("oplay(" + lista + ",X).");
                p = Integer.parseInt(info.getTerm("X").toString());
                lista.set(p - 1, "o");
                desenhar((JButton) panel.getComponent(p - 1));
                info = engine.solve("vitoria(" + lista + ",o).");
                if (info.isSuccess()) {
                    lista.clear();
                    JButton btn;
                    for (int i = 0; i < 9; i++) {
                        btn = (JButton) panel.getComponent(i);
                        if (btn.getText() == "O") {
                            btn.setBackground(Color.red);
                            panel.add(btn, i);
                        }
                    }
                }
                info = engine.solve("vitoriaA(" + lista + ").");
                int x = contA();
                if (x < 2 || (!info.isSuccess() && x < 3)) {
                    lista.clear();
                }
                String s = engine.solveNext().toString();
                if (s.contains("yes.")) {
                    lista.clear();
                    JButton btn;
                    for (int i = 0; i < 9; i++) {
                        btn = (JButton) panel.getComponent(i);
                        if (btn.getText() == "O") {
                            btn.setBackground(Color.red);
                            panel.add(btn, i);
                        }
                    }
                }
            } catch (Exception e) {
            }
        } else;
    }

    public void setX(JButton b, int x) {
        b.setName(x + "");
    }

    public int contA() {
        int x = 0;
        for (String string : lista) {
            if (string == "a") {
                x += 1;
            }
        }
        return x;
    }

    public int getX(JButton b) {
        return Integer.parseInt(b.getName());
    }
}
