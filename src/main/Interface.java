package main;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;
import java.awt.Font;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

import alice.tuprolog.*;
import alice.tuprolog.exceptions.InvalidTheoryException;
import alice.tuprolog.exceptions.MalformedGoalException;
import alice.tuprolog.exceptions.NoSolutionException;
import alice.tuprolog.exceptions.UnknownVarException;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Interface implements ActionListener {

    private boolean player2 = false;
    private final Prolog engine = new Prolog();
    private final List<String> lista = new ArrayList();
    private JPanel panel;
    private int contA = 9;

    public Interface() {
        criarTela();
    }

    private void criarTela() {
        JFrame janela = new JFrame("JOGO DA VELHA");
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
        if (player2 && "".equals(b.getText())) {
            b.setText("O");
            player2 = !player2;
        } else if ("".equals(b.getText())) {
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
            contA -= 1;
            int p = Integer.parseInt(b.getName());
            lista.set(p - 1, "x");
            try {
                if (contA < 1) {
                    lista.clear();
                } else {
                    Theory theory = new Theory(new FileInputStream("velha.pl"));
                    engine.setTheory(theory);
                    engine.solve("oplay(" + lista + ",X).");
                    SolveInfo info = engine.solve("oplay(" + lista + ",X).");
                    p = Integer.parseInt(info.getTerm("X").toString());
                    lista.set(p - 1, "o");
                    desenhar((JButton) panel.getComponent(p - 1));
                    contA -= 1;
                    info = engine.solve("vitoria(" + lista + ",o).");
                    if (info.isSuccess()) {
                        lista.clear();
                        JButton btn;
                        for (int i = 0; i < 9; i++) {
                            btn = (JButton) panel.getComponent(i);
                            if ("O".equals(btn.getText())) {
                                btn.setBackground(Color.red);
                                panel.add(btn, i);
                            }
                        }
                    } else if (contA < 4) {
                        info = engine.solve("empate(" + lista + ").");
                        if (info.isSuccess()) {
                            lista.clear();
                        }
                    }
                }
            } catch (InvalidTheoryException | MalformedGoalException
                    | UnknownVarException | IOException
                    | NumberFormatException | NoSolutionException e) {
                Logger.getLogger(Interface.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public static void main(String[] args) {
        Interface aInterface = new Interface();
    }
}
