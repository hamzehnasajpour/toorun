#ifndef MQTTTREEMODEL_H
#define MQTTTREEMODEL_H

#include <QAbstractItemModel>
#include <QModelIndex>
#include <QVariant>

class MqttTreeItem;

class MqttTreeModel : public QAbstractItemModel
{
    Q_OBJECT

public:
    enum TreeModelRoles
    {
        TreeModelRoleName = Qt::UserRole + 1,
        TreeModelRoleDescription
    };

    explicit MqttTreeModel(QObject *parent = 0);
    ~MqttTreeModel();

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    Qt::ItemFlags flags(const QModelIndex &index) const Q_DECL_OVERRIDE;
    QVariant headerData(int section, Qt::Orientation orientation,
                        int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;
    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QModelIndex parent(const QModelIndex &index) const Q_DECL_OVERRIDE;
    int rowCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const override;
    void addTopic(const QString &topic, const QString &message);
    void clear();
    
private:
    QVariant newCustomType(const QString &text, int position);

    MqttTreeItem *m_mqttRootTreeItem;
    QStringList m_topics;
    QHash<int, QByteArray> m_roleNameMapping;
};

#endif
